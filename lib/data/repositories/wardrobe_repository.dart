import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';
import '../models/wardrobe_item_model.dart';
import '../../core/services/storage/hive_service.dart';
import '../../core/services/ai/openai_service.dart';
import '../../core/services/camera/camera_service.dart';
import '../services/cloud_storage_service.dart';

// Provider for wardrobe repository
final wardrobeRepositoryProvider = Provider<WardrobeRepository>((ref) {
  return WardrobeRepository();
});

// Provider for wardrobe items
final wardrobeItemsProvider = StateNotifierProvider<WardrobeNotifier, AsyncValue<List<WardrobeItemModel>>>((ref) {
  return WardrobeNotifier(ref.watch(wardrobeRepositoryProvider));
});

// Provider for filtered wardrobe items
final filteredWardrobeProvider = Provider.family<List<WardrobeItemModel>, WardrobeFilter>((ref, filter) {
  final items = ref.watch(wardrobeItemsProvider).value ?? [];
  
  switch (filter.type) {
    case FilterType.category:
      return items.where((item) => item.category == filter.value).toList();
    case FilterType.color:
      return items.where((item) => item.colors.contains(filter.value)).toList();
    case FilterType.search:
      final query = filter.value.toLowerCase();
      return items.where((item) {
        return item.name.toLowerCase().contains(query) ||
               item.brand?.toLowerCase().contains(query) == true ||
               item.tags.any((tag) => tag.toLowerCase().contains(query));
      }).toList();
    case FilterType.season:
      return items.where((item) => item.season == filter.value).toList();
    case FilterType.favorite:
      return items.where((item) => item.isFavorite).toList();
    default:
      return items;
  }
});

class WardrobeNotifier extends StateNotifier<AsyncValue<List<WardrobeItemModel>>> {
  final WardrobeRepository _repository;
  
  WardrobeNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadItems();
  }
  
  Future<void> loadItems() async {
    state = const AsyncValue.loading();
    try {
      final items = await _repository.loadWardrobeItems();
      state = AsyncValue.data(items);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> addItem(WardrobeItemModel item) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      await _repository.addItem(item);
      await loadItems();
    } catch (e, stack) {
      state = previousState;
      throw e;
    }
  }
  
  Future<void> deleteItem(String id) async {
    await _repository.deleteItem(id);
    await loadItems();
  }
  
  Future<void> toggleFavorite(String id) async {
    await _repository.toggleFavorite(id);
    await loadItems();
  }
}

class WardrobeRepository {
  final Logger _logger = Logger();
  final _uuid = Uuid();
  final CloudStorageService _cloudStorage = CloudStorageService();
  
  // Load items from Hive
  Future<List<WardrobeItemModel>> loadWardrobeItems() async {
    try {
      final items = HiveService.getAllWardrobeItems();
      _logger.i('Loaded ${items.length} wardrobe items from local storage');
      
      // TODO: Sync with cloud storage
      return items;
    } catch (e) {
      _logger.e('Error loading wardrobe items: $e');
      return [];
    }
  }
  
  // Add new item with AI tagging and background removal
  Future<WardrobeItemModel> addItem(WardrobeItemModel item) async {
    try {
      // Save to local storage
      await HiveService.saveWardrobeItem(item);
      
      // Upload to cloud storage
      if (item.imagePath.isNotEmpty) {
        final cloudUrl = await _cloudStorage.uploadImage(File(item.imagePath));
        final updatedItem = item.copyWith(cloudImageUrl: cloudUrl);
        await HiveService.saveWardrobeItem(updatedItem);
        return updatedItem;
      }
      
      return item;
    } catch (e) {
      _logger.e('Error adding wardrobe item: $e');
      throw e;
    }
  }
  
  // Process image with background removal and AI tagging
  Future<WardrobeItemModel> processNewItem({
    required File imageFile,
    required String name,
    required String category,
    String? brand,
    List<String>? colors,
    String? season,
    List<String>? occasions,
  }) async {
    try {
      // Remove background
      final processedImage = await CameraService._removeBackground(imageFile);
      
      // Generate AI tags
      final tags = await OpenAIService.generateMetaTags(processedImage);
      
      // Create wardrobe item
      final item = WardrobeItemModel(
        id: _uuid.v4(),
        name: name,
        category: category,
        brand: brand,
        colors: colors ?? [],
        tags: tags,
        imagePath: processedImage.path,
        originalImagePath: imageFile.path,
        createdAt: DateTime.now(),
        season: season,
        occasions: occasions,
      );
      
      return await addItem(item);
    } catch (e) {
      _logger.e('Error processing new item: $e');
      throw e;
    }
  }
  
  // Batch process multiple images
  Future<List<WardrobeItemModel>> processBatchItems({
    required List<File> imageFiles,
    required String category,
  }) async {
    final items = <WardrobeItemModel>[];
    
    for (final imageFile in imageFiles) {
      try {
        final item = await processNewItem(
          imageFile: imageFile,
          name: 'Item ${items.length + 1}',
          category: category,
        );
        items.add(item);
      } catch (e) {
        _logger.e('Error processing batch item: $e');
      }
    }
    
    return items;
  }
  
  Future<void> deleteItem(String id) async {
    try {
      await HiveService.deleteWardrobeItem(id);
      _logger.i('Deleted wardrobe item: $id');
    } catch (e) {
      _logger.e('Error deleting item: $e');
      throw e;
    }
  }
  
  Future<void> toggleFavorite(String id) async {
    try {
      final items = HiveService.getAllWardrobeItems();
      final item = items.firstWhere((i) => i.id == id);
      final updated = item.copyWith(isFavorite: !item.isFavorite);
      await HiveService.saveWardrobeItem(updated);
    } catch (e) {
      _logger.e('Error toggling favorite: $e');
    }
  }
  
  // Search using semantic tags
  List<WardrobeItemModel> semanticSearch(String query) {
    final items = HiveService.getAllWardrobeItems();
    final queryLower = query.toLowerCase();
    
    // Score each item based on tag relevance
    final scoredItems = items.map((item) {
      int score = 0;
      
      // Exact name match
      if (item.name.toLowerCase().contains(queryLower)) score += 10;
      
      // Category match
      if (item.category.toLowerCase().contains(queryLower)) score += 5;
      
      // Brand match
      if (item.brand?.toLowerCase().contains(queryLower) == true) score += 5;
      
      // Tag matches (semantic search)
      for (final tag in item.tags) {
        if (tag.toLowerCase().contains(queryLower)) score += 2;
      }
      
      return MapEntry(item, score);
    }).where((entry) => entry.value > 0).toList();
    
    // Sort by score
    scoredItems.sort((a, b) => b.value.compareTo(a.value));
    
    return scoredItems.map((e) => e.key).toList();
  }
}

enum FilterType { category, color, search, season, favorite, none }

class WardrobeFilter {
  final FilterType type;
  final String value;
  
  WardrobeFilter({required this.type, required this.value});
}

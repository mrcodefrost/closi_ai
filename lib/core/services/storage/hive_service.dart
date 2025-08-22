import 'package:hive_flutter/hive_flutter.dart';
import '../../../data/models/wardrobe_item_model.dart';
import '../../../data/models/outfit_model.dart';
import '../../../data/models/user_profile_model.dart';

class HiveService {
  static const String wardrobeBoxName = 'wardrobe';
  static const String outfitBoxName = 'outfits';
  static const String userProfileBoxName = 'user_profile';
  static const String settingsBoxName = 'settings';
  static const String cacheBoxName = 'cache';
  
  static late Box<WardrobeItemModel> wardrobeBox;
  static late Box<OutfitModel> outfitBox;
  static late Box<UserProfileModel> userProfileBox;
  static late Box settingsBox;
  static late Box cacheBox;
  
  static Future<void> init() async {
    // Register adapters
    Hive.registerAdapter(WardrobeItemModelAdapter());
    Hive.registerAdapter(OutfitModelAdapter());
    Hive.registerAdapter(UserProfileModelAdapter());
    
    // Open boxes
    wardrobeBox = await Hive.openBox<WardrobeItemModel>(wardrobeBoxName);
    outfitBox = await Hive.openBox<OutfitModel>(outfitBoxName);
    userProfileBox = await Hive.openBox<UserProfileModel>(userProfileBoxName);
    settingsBox = await Hive.openBox(settingsBoxName);
    cacheBox = await Hive.openBox(cacheBoxName);
  }
  
  // Wardrobe operations
  static Future<void> saveWardrobeItem(WardrobeItemModel item) async {
    await wardrobeBox.put(item.id, item);
  }
  
  static List<WardrobeItemModel> getAllWardrobeItems() {
    return wardrobeBox.values.toList();
  }
  
  static Future<void> deleteWardrobeItem(String id) async {
    await wardrobeBox.delete(id);
  }
  
  // Outfit operations
  static Future<void> saveOutfit(OutfitModel outfit) async {
    await outfitBox.put(outfit.id, outfit);
  }
  
  static List<OutfitModel> getAllOutfits() {
    return outfitBox.values.toList();
  }
  
  // Settings operations
  static dynamic getSetting(String key, {dynamic defaultValue}) {
    return settingsBox.get(key, defaultValue: defaultValue);
  }
  
  static Future<void> setSetting(String key, dynamic value) async {
    await settingsBox.put(key, value);
  }
  
  // Cache operations for lightweight data
  static Future<void> cacheData(String key, dynamic value) async {
    await cacheBox.put(key, value);
  }
  
  static dynamic getCachedData(String key) {
    return cacheBox.get(key);
  }
  
  static Future<void> clearCache() async {
    await cacheBox.clear();
  }
}

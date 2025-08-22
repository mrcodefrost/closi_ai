import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../models/wardrobe_item.dart';
import '../models/outfit.dart';
import '../models/user_profile.dart';

class ApiService extends GetxService {
  late Dio _dio;
  final String baseUrl = 'https://api.closi.app'; // Replace with actual API URL

  @override
  void onInit() {
    super.onInit();
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    
    // Add interceptors for auth tokens, logging, etc.
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if available
        // options.headers['Authorization'] = 'Bearer $token';
        handler.next(options);
      },
      onError: (error, handler) {
        print('API Error: ${error.message}');
        handler.next(error);
      },
    ));
  }

  // Wardrobe Items
  Future<List<WardrobeItem>> getWardrobeItems() async {
    try {
      final response = await _dio.get('/wardrobe');
      return (response.data as List)
          .map((item) => WardrobeItem.fromJson(item))
          .toList();
    } catch (e) {
      print('Error fetching wardrobe items: $e');
      return [];
    }
  }

  Future<WardrobeItem?> addWardrobeItem(WardrobeItem item) async {
    try {
      final response = await _dio.post('/wardrobe', data: item.toJson());
      return WardrobeItem.fromJson(response.data);
    } catch (e) {
      print('Error adding wardrobe item: $e');
      return null;
    }
  }

  Future<WardrobeItem?> updateWardrobeItem(WardrobeItem item) async {
    try {
      final response = await _dio.put('/wardrobe/${item.id}', data: item.toJson());
      return WardrobeItem.fromJson(response.data);
    } catch (e) {
      print('Error updating wardrobe item: $e');
      return null;
    }
  }

  Future<bool> deleteWardrobeItem(String itemId) async {
    try {
      await _dio.delete('/wardrobe/$itemId');
      return true;
    } catch (e) {
      print('Error deleting wardrobe item: $e');
      return false;
    }
  }

  // Outfits
  Future<List<Outfit>> getOutfits() async {
    try {
      final response = await _dio.get('/outfits');
      return (response.data as List)
          .map((outfit) => Outfit.fromJson(outfit))
          .toList();
    } catch (e) {
      print('Error fetching outfits: $e');
      return [];
    }
  }

  Future<Outfit?> saveOutfit(Outfit outfit) async {
    try {
      final response = await _dio.post('/outfits', data: outfit.toJson());
      return Outfit.fromJson(response.data);
    } catch (e) {
      print('Error saving outfit: $e');
      return null;
    }
  }

  Future<bool> deleteOutfit(String outfitId) async {
    try {
      await _dio.delete('/outfits/$outfitId');
      return true;
    } catch (e) {
      print('Error deleting outfit: $e');
      return false;
    }
  }

  // User Profile
  Future<UserProfile?> getUserProfile() async {
    try {
      final response = await _dio.get('/profile');
      return UserProfile.fromJson(response.data);
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  Future<UserProfile?> updateUserProfile(UserProfile profile) async {
    try {
      final response = await _dio.put('/profile', data: profile.toJson());
      return UserProfile.fromJson(response.data);
    } catch (e) {
      print('Error updating user profile: $e');
      return null;
    }
  }

  // AI Recommendations
  Future<List<Outfit>> getRecommendedOutfits({String? occasion, String? weather}) async {
    try {
      final response = await _dio.get('/recommendations/outfits', queryParameters: {
        if (occasion != null) 'occasion': occasion,
        if (weather != null) 'weather': weather,
      });
      return (response.data as List)
          .map((outfit) => Outfit.fromJson(outfit))
          .toList();
    } catch (e) {
      print('Error fetching recommendations: $e');
      return [];
    }
  }

  // Image Upload
  Future<String?> uploadImage(String filePath) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(filePath),
      });
      final response = await _dio.post('/upload', data: formData);
      return response.data['url'];
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}

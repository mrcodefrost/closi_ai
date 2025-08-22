import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/wardrobe_item.dart';
import '../models/outfit.dart';
import '../models/user_profile.dart';

class LocalStorageService extends GetxService {
  late GetStorage _storage;
  
  static const String _wardrobeKey = 'wardrobe_items';
  static const String _outfitsKey = 'outfits';
  static const String _profileKey = 'user_profile';
  static const String _preferencesKey = 'app_preferences';

  @override
  void onInit() {
    super.onInit();
    _storage = GetStorage();
  }

  // Wardrobe Items
  Future<List<WardrobeItem>> getWardrobeItems() async {
    try {
      final data = _storage.read(_wardrobeKey);
      if (data != null) {
        final List<dynamic> jsonList = jsonDecode(data);
        return jsonList.map((json) => WardrobeItem.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error reading wardrobe items: $e');
      return [];
    }
  }

  Future<void> saveWardrobeItems(List<WardrobeItem> items) async {
    try {
      final jsonList = items.map((item) => item.toJson()).toList();
      await _storage.write(_wardrobeKey, jsonEncode(jsonList));
    } catch (e) {
      print('Error saving wardrobe items: $e');
    }
  }

  // Outfits
  Future<List<Outfit>> getOutfits() async {
    try {
      final data = _storage.read(_outfitsKey);
      if (data != null) {
        final List<dynamic> jsonList = jsonDecode(data);
        return jsonList.map((json) => Outfit.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error reading outfits: $e');
      return [];
    }
  }

  Future<void> saveOutfits(List<Outfit> outfits) async {
    try {
      final jsonList = outfits.map((outfit) => outfit.toJson()).toList();
      await _storage.write(_outfitsKey, jsonEncode(jsonList));
    } catch (e) {
      print('Error saving outfits: $e');
    }
  }

  // User Profile
  Future<UserProfile?> getUserProfile() async {
    try {
      final data = _storage.read(_profileKey);
      if (data != null) {
        return UserProfile.fromJson(jsonDecode(data));
      }
      return null;
    } catch (e) {
      print('Error reading user profile: $e');
      return null;
    }
  }

  Future<void> saveUserProfile(UserProfile profile) async {
    try {
      await _storage.write(_profileKey, jsonEncode(profile.toJson()));
    } catch (e) {
      print('Error saving user profile: $e');
    }
  }

  // App Preferences
  Future<Map<String, dynamic>> getPreferences() async {
    try {
      final data = _storage.read(_preferencesKey);
      if (data != null) {
        return jsonDecode(data);
      }
      return {};
    } catch (e) {
      print('Error reading preferences: $e');
      return {};
    }
  }

  Future<void> savePreferences(Map<String, dynamic> preferences) async {
    try {
      await _storage.write(_preferencesKey, jsonEncode(preferences));
    } catch (e) {
      print('Error saving preferences: $e');
    }
  }

  // Clear all data
  Future<void> clearAll() async {
    try {
      await _storage.erase();
    } catch (e) {
      print('Error clearing storage: $e');
    }
  }

  // Check if first launch
  bool isFirstLaunch() {
    return _storage.read('first_launch') ?? true;
  }

  Future<void> setFirstLaunchComplete() async {
    await _storage.write('first_launch', false);
  }

  // Auth token management
  String? getAuthToken() {
    return _storage.read('auth_token');
  }

  Future<void> saveAuthToken(String token) async {
    await _storage.write('auth_token', token);
  }

  Future<void> clearAuthToken() async {
    await _storage.remove('auth_token');
  }
}

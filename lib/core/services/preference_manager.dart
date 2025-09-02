import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static final GetStorage _storage = GetStorage();

  // Keys
  static const String token = "token";
  static const String keyIsDarkMode = "keyIsDarkMode";

  // Write
  static Future<void> setData(String key, dynamic value) async =>
      await _storage.write(key, value);

  // Read
  static String? getString(String key) => _storage.read(key)?.toString();
  static bool? getBool(String key) => _storage.read(key) as bool?;
  static int? getInt(String key) => _storage.read(key) as int?;

  // Delete
  static Future<void> deleteKey(String key) async => await _storage.remove(key);
  static Future<void> clearAll() async => await _storage.erase();
}

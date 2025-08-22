import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

class CloudStorageService {
  final Logger _logger = Logger();
  final Dio _dio = Dio();
  
  // Replace with your actual cloud storage endpoint
  static const String _baseUrl = String.fromEnvironment(
    'CLOUD_STORAGE_URL',
    defaultValue: 'https://api.cloudinary.com/v1_1/YOUR_CLOUD_NAME',
  );
  
  static const String _uploadPreset = String.fromEnvironment(
    'UPLOAD_PRESET',
    defaultValue: 'ml_default',
  );
  
  Future<String> uploadImage(File imageFile) async {
    try {
      final fileName = path.basename(imageFile.path);
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
        'upload_preset': _uploadPreset,
        'folder': 'closi/wardrobe',
      });
      
      final response = await _dio.post(
        '$_baseUrl/image/upload',
        data: formData,
      );
      
      if (response.statusCode == 200) {
        final url = response.data['secure_url'];
        _logger.i('Image uploaded successfully: $url');
        return url;
      }
      
      throw Exception('Failed to upload image');
    } catch (e) {
      _logger.e('Error uploading image: $e');
      return '';
    }
  }
  
  Future<String> uploadBodyPhoto(File imageFile) async {
    try {
      final fileName = path.basename(imageFile.path);
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
        'upload_preset': _uploadPreset,
        'folder': 'closi/body_photos',
      });
      
      final response = await _dio.post(
        '$_baseUrl/image/upload',
        data: formData,
      );
      
      if (response.statusCode == 200) {
        final url = response.data['secure_url'];
        _logger.i('Body photo uploaded successfully: $url');
        return url;
      }
      
      throw Exception('Failed to upload body photo');
    } catch (e) {
      _logger.e('Error uploading body photo: $e');
      return '';
    }
  }
  
  Future<bool> deleteImage(String publicId) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/image/destroy',
        data: {
          'public_id': publicId,
        },
      );
      
      return response.statusCode == 200;
    } catch (e) {
      _logger.e('Error deleting image: $e');
      return false;
    }
  }
}

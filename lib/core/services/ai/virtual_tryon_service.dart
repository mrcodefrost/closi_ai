import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../ml/body_capture_service.dart';

class VirtualTryOnService {
  static final Logger _logger = Logger();
  static final Dio _dio = Dio();
  
  // Fast warping service endpoint (your custom ML model)
  static const String _warpingServiceUrl = String.fromEnvironment(
    'WARPING_SERVICE_URL',
    defaultValue: 'http://localhost:8000/api/warp',
  );
  
  // Kling/Huhu API for final high-quality try-ons
  static const String _klingApiUrl = String.fromEnvironment(
    'KLING_API_URL',
    defaultValue: 'https://api.kling.ai/v1/tryon',
  );
  
  static const String _klingApiKey = String.fromEnvironment(
    'KLING_API_KEY',
    defaultValue: '',
  );
  
  /// Fast 2D warping for real-time preview
  static Future<File?> fastWarpClothing({
    required File clothingImage,
    required File bodyImage,
    required BodyMeasurements measurements,
  }) async {
    try {
      final formData = FormData.fromMap({
        'clothing': await MultipartFile.fromFile(clothingImage.path),
        'body': await MultipartFile.fromFile(bodyImage.path),
        'measurements': json.encode(measurements.toJson()),
        'mode': 'fast',
      });
      
      final response = await _dio.post(
        _warpingServiceUrl,
        data: formData,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      
      if (response.statusCode == 200) {
        final tempFile = File('${Directory.systemTemp.path}/warped_${DateTime.now().millisecondsSinceEpoch}.png');
        await tempFile.writeAsBytes(response.data);
        _logger.i('Fast warping completed successfully');
        return tempFile;
      }
      
      return null;
    } catch (e) {
      _logger.e('Error in fast warping: $e');
      return null;
    }
  }
  
  /// High-quality try-on using Kling/Huhu API
  static Future<String?> generateHighQualityTryOn({
    required String clothingImageUrl,
    required String bodyImageUrl,
    Map<String, dynamic>? style,
  }) async {
    try {
      final response = await _dio.post(
        _klingApiUrl,
        data: {
          'garment_url': clothingImageUrl,
          'model_url': bodyImageUrl,
          'style': style ?? {'quality': 'high', 'preserve_pose': true},
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $_klingApiKey',
            'Content-Type': 'application/json',
          },
        ),
      );
      
      if (response.statusCode == 200) {
        final resultUrl = response.data['result_url'];
        _logger.i('High-quality try-on generated: $resultUrl');
        return resultUrl;
      }
      
      return null;
    } catch (e) {
      _logger.e('Error generating high-quality try-on: $e');
      return null;
    }
  }
  
  /// Batch process multiple clothing items for outfit try-on
  static Future<List<File>> batchWarpOutfit({
    required List<File> clothingImages,
    required File bodyImage,
    required BodyMeasurements measurements,
  }) async {
    final warpedImages = <File>[];
    
    for (final clothing in clothingImages) {
      final warped = await fastWarpClothing(
        clothingImage: clothing,
        bodyImage: bodyImage,
        measurements: measurements,
      );
      
      if (warped != null) {
        warpedImages.add(warped);
      }
    }
    
    return warpedImages;
  }
  
  /// Composite multiple warped items into single outfit image
  static Future<File?> compositeOutfit({
    required List<File> warpedItems,
    required File bodyImage,
  }) async {
    try {
      final formData = FormData.fromMap({
        'body': await MultipartFile.fromFile(bodyImage.path),
        'items': await Future.wait(
          warpedItems.map((file) => MultipartFile.fromFile(file.path)),
        ),
        'mode': 'composite',
      });
      
      final response = await _dio.post(
        '$_warpingServiceUrl/composite',
        data: formData,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      
      if (response.statusCode == 200) {
        final tempFile = File('${Directory.systemTemp.path}/outfit_${DateTime.now().millisecondsSinceEpoch}.png');
        await tempFile.writeAsBytes(response.data);
        return tempFile;
      }
      
      return null;
    } catch (e) {
      _logger.e('Error compositing outfit: $e');
      return null;
    }
  }
}

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_selfie_segmentation/google_mlkit_selfie_segmentation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import 'package:logger/logger.dart';

class CameraService {
  static final Logger _logger = Logger();
  static final ImagePicker _picker = ImagePicker();
  static final _uuid = Uuid();
  
  static late List<CameraDescription> cameras;
  static CameraController? controller;
  
  // Selfie segmenter for background removal
  static final _segmenter = SelfieSegmenter(
    mode: SegmenterMode.single,
    enableRawSizeMask: true,
  );
  
  static Future<void> initializeCameras() async {
    try {
      cameras = await availableCameras();
      _logger.i('Found ${cameras.length} cameras');
    } catch (e) {
      _logger.e('Error initializing cameras: $e');
    }
  }
  
  /// Capture single photo with optional background removal
  static Future<File?> captureSinglePhoto({
    required ImageSource source,
    bool removeBackground = true,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 95,
      );
      
      if (image == null) return null;
      
      File processedFile = File(image.path);
      
      if (removeBackground) {
        processedFile = await _removeBackground(processedFile);
      }
      
      return processedFile;
    } catch (e) {
      _logger.e('Error capturing photo: $e');
      return null;
    }
  }
  
  /// Capture multiple photos in batch mode
  static Future<List<File>> captureBatchPhotos({
    bool removeBackground = true,
    int maxPhotos = 10,
  }) async {
    final List<File> photos = [];
    
    try {
      // Use multi-image picker if available
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 95,
        limit: maxPhotos,
      );
      
      for (final image in images) {
        File processedFile = File(image.path);
        
        if (removeBackground) {
          processedFile = await _removeBackground(processedFile);
        }
        
        photos.add(processedFile);
      }
      
      return photos;
    } catch (e) {
      _logger.e('Error capturing batch photos: $e');
      return photos;
    }
  }
  
  /// Remove background from image using ML Kit
  static Future<File> _removeBackground(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final mask = await _segmenter.processImage(inputImage);
      
      if (mask == null) {
        _logger.w('No mask generated, returning original image');
        return imageFile;
      }
      
      // Read the original image
      final originalBytes = await imageFile.readAsBytes();
      final originalImage = img.decodeImage(originalBytes);
      
      if (originalImage == null) {
        _logger.e('Failed to decode image');
        return imageFile;
      }
      
      // Create transparent image with segmented foreground
      final outputImage = img.Image(
        width: originalImage.width,
        height: originalImage.height,
      );
      
      // Apply mask to remove background
      for (int y = 0; y < originalImage.height; y++) {
        for (int x = 0; x < originalImage.width; x++) {
          final pixelIndex = y * originalImage.width + x;
          final confidence = mask[pixelIndex];
          
          if (confidence > 0.5) {
            // Keep foreground pixel
            outputImage.setPixel(x, y, originalImage.getPixel(x, y));
          } else {
            // Make background transparent
            outputImage.setPixelRgba(x, y, 0, 0, 0, 0);
          }
        }
      }
      
      // Save processed image
      final tempDir = await getTemporaryDirectory();
      final outputPath = path.join(
        tempDir.path,
        '${_uuid.v4()}_nobg.png',
      );
      
      final outputFile = File(outputPath);
      await outputFile.writeAsBytes(img.encodePng(outputImage));
      
      _logger.i('Background removed successfully');
      return outputFile;
    } catch (e) {
      _logger.e('Error removing background: $e');
      return imageFile;
    }
  }
  
  /// Capture body photo for virtual try-on
  static Future<File?> captureBodyPhoto({
    required ImageSource source,
  }) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 100, // High quality for body detection
      );
      
      if (image == null) return null;
      
      // TODO: Add pose detection validation here
      return File(image.path);
    } catch (e) {
      _logger.e('Error capturing body photo: $e');
      return null;
    }
  }
  
  static void dispose() {
    controller?.dispose();
    _segmenter.close();
  }
}

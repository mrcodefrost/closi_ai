import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// A service class to handle image selection from camera/gallery.
/// Keeps UI clean and helps in testing & scaling.
class ImageService {
  final ImagePicker _picker = ImagePicker();

  /// Pick image from camera
  Future<File?> pickFromCamera({int imageQuality = 85}) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality, // compress image
        maxWidth: 1080, // avoid huge files
      );
      if (file == null) return null;
      return File(file.path);
    } catch (e) {
      debugPrint('❌ Camera error: $e');
      return null;
    }
  }

  /// Pick image from gallery
  Future<File?> pickFromGallery({int imageQuality = 85}) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
        maxWidth: 1080,
      );
      if (file == null) return null;
      return File(file.path);
    } catch (e) {
      debugPrint('❌ Gallery error: $e');
      return null;
    }
  }

  /// Pick multiple images from gallery
  Future<List<File>> pickMultipleFromGallery({int imageQuality = 85}) async {
    try {
      final List<XFile> files = await _picker.pickMultiImage(
        imageQuality: imageQuality,
        maxWidth: 1080,
      );
      return files.map((f) => File(f.path)).toList();
    } catch (e) {
      debugPrint('❌ Multi-image error: $e');
      return [];
    }
  }
}

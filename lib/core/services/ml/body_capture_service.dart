import 'dart:io';
import 'dart:math' as math;
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';

class BodyCaptureService {
  static final Logger _logger = Logger();
  
  static final _poseDetector = PoseDetector(
    options: PoseDetectorOptions(
      mode: PoseDetectionMode.single,
      model: PoseDetectionModel.accurate,
    ),
  );
  
  /// Validate and extract body measurements from photo
  static Future<BodyMeasurements?> analyzeBodyPhoto(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final poses = await _poseDetector.processImage(inputImage);
      
      if (poses.isEmpty) {
        _logger.w('No pose detected in image');
        return null;
      }
      
      final pose = poses.first;
      final measurements = _extractMeasurements(pose);
      
      _logger.i('Body measurements extracted successfully');
      return measurements;
    } catch (e) {
      _logger.e('Error analyzing body photo: $e');
      return null;
    }
  }
  
  /// Extract body measurements from pose landmarks
  static BodyMeasurements _extractMeasurements(Pose pose) {
    final landmarks = pose.landmarks;
    
    // Get key body points
    final leftShoulder = landmarks[PoseLandmarkType.leftShoulder];
    final rightShoulder = landmarks[PoseLandmarkType.rightShoulder];
    final leftHip = landmarks[PoseLandmarkType.leftHip];
    final rightHip = landmarks[PoseLandmarkType.rightHip];
    final leftAnkle = landmarks[PoseLandmarkType.leftAnkle];
    final rightAnkle = landmarks[PoseLandmarkType.rightAnkle];
    
    // Calculate measurements
    double? shoulderWidth;
    double? hipWidth;
    double? torsoLength;
    double? legLength;
    double? estimatedHeight;
    
    if (leftShoulder != null && rightShoulder != null) {
      shoulderWidth = _calculateDistance(leftShoulder.position, rightShoulder.position);
    }
    
    if (leftHip != null && rightHip != null) {
      hipWidth = _calculateDistance(leftHip.position, rightHip.position);
    }
    
    if (leftShoulder != null && leftHip != null) {
      torsoLength = _calculateDistance(leftShoulder.position, leftHip.position);
    }
    
    if (leftHip != null && leftAnkle != null) {
      legLength = _calculateDistance(leftHip.position, leftAnkle.position);
    }
    
    if (torsoLength != null && legLength != null) {
      // Rough height estimation (normalized)
      estimatedHeight = (torsoLength + legLength) * 2.5;
    }
    
    // Determine body type based on proportions
    String bodyType = 'Average';
    if (shoulderWidth != null && hipWidth != null) {
      final ratio = shoulderWidth / hipWidth;
      if (ratio > 1.3) {
        bodyType = 'Inverted Triangle';
      } else if (ratio < 0.8) {
        bodyType = 'Pear';
      } else if ((ratio - 1.0).abs() < 0.1) {
        bodyType = 'Rectangle';
      }
    }
    
    return BodyMeasurements(
      shoulderWidth: shoulderWidth,
      hipWidth: hipWidth,
      torsoLength: torsoLength,
      legLength: legLength,
      estimatedHeight: estimatedHeight,
      bodyType: bodyType,
      poseConfidence: _calculatePoseConfidence(pose),
      keyPoints: _extractKeyPoints(pose),
    );
  }
  
  /// Calculate distance between two points
  static double _calculateDistance(Point<int> p1, Point<int> p2) {
    final dx = (p1.x - p2.x).toDouble();
    final dy = (p1.y - p2.y).toDouble();
    return math.sqrt(dx * dx + dy * dy);
  }
  
  /// Calculate overall pose detection confidence
  static double _calculatePoseConfidence(Pose pose) {
    final landmarks = pose.landmarks.values.toList();
    if (landmarks.isEmpty) return 0.0;
    
    double totalLikelihood = 0;
    for (final landmark in landmarks) {
      totalLikelihood += landmark.likelihood;
    }
    
    return totalLikelihood / landmarks.length;
  }
  
  /// Extract key body points for virtual try-on
  static Map<String, Point<int>> _extractKeyPoints(Pose pose) {
    final keyPoints = <String, Point<int>>{};
    
    final pointsToExtract = [
      PoseLandmarkType.nose,
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.leftElbow,
      PoseLandmarkType.rightElbow,
      PoseLandmarkType.leftWrist,
      PoseLandmarkType.rightWrist,
      PoseLandmarkType.leftHip,
      PoseLandmarkType.rightHip,
      PoseLandmarkType.leftKnee,
      PoseLandmarkType.rightKnee,
      PoseLandmarkType.leftAnkle,
      PoseLandmarkType.rightAnkle,
    ];
    
    for (final type in pointsToExtract) {
      final landmark = pose.landmarks[type];
      if (landmark != null) {
        keyPoints[type.name] = landmark.position;
      }
    }
    
    return keyPoints;
  }
  
  /// Validate if photo is suitable for virtual try-on
  static Future<bool> validateBodyPhoto(File imageFile) async {
    try {
      final measurements = await analyzeBodyPhoto(imageFile);
      if (measurements == null) return false;
      
      // Check if we have minimum required landmarks
      final requiredPoints = ['leftShoulder', 'rightShoulder', 'leftHip', 'rightHip'];
      for (final point in requiredPoints) {
        if (!measurements.keyPoints.containsKey(point)) {
          _logger.w('Missing required landmark: $point');
          return false;
        }
      }
      
      // Check confidence threshold
      if (measurements.poseConfidence < 0.5) {
        _logger.w('Pose confidence too low: ${measurements.poseConfidence}');
        return false;
      }
      
      return true;
    } catch (e) {
      _logger.e('Error validating body photo: $e');
      return false;
    }
  }
  
  static void dispose() {
    _poseDetector.close();
  }
}

class BodyMeasurements {
  final double? shoulderWidth;
  final double? hipWidth;
  final double? torsoLength;
  final double? legLength;
  final double? estimatedHeight;
  final String bodyType;
  final double poseConfidence;
  final Map<String, Point<int>> keyPoints;
  
  BodyMeasurements({
    this.shoulderWidth,
    this.hipWidth,
    this.torsoLength,
    this.legLength,
    this.estimatedHeight,
    required this.bodyType,
    required this.poseConfidence,
    required this.keyPoints,
  });
  
  Map<String, dynamic> toJson() => {
    'shoulderWidth': shoulderWidth,
    'hipWidth': hipWidth,
    'torsoLength': torsoLength,
    'legLength': legLength,
    'estimatedHeight': estimatedHeight,
    'bodyType': bodyType,
    'poseConfidence': poseConfidence,
    'keyPoints': keyPoints.map((k, v) => MapEntry(k, {'x': v.x, 'y': v.y})),
  };
}

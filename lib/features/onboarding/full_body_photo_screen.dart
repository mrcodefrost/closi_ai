import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class FullBodyPhotoScreen extends StatefulWidget {
  const FullBodyPhotoScreen({super.key});

  @override
  State<FullBodyPhotoScreen> createState() => _FullBodyPhotoScreenState();
}

class _FullBodyPhotoScreenState extends State<FullBodyPhotoScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isRearCamera = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _cameraController = CameraController(
          cameras[_isRearCamera ? 0 : 1],
          ResolutionPreset.high,
        );
        await _cameraController!.initialize();
        if (mounted) {
          setState(() => _isCameraInitialized = true);
        }
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  void _switchCamera() async {
    setState(() => _isRearCamera = !_isRearCamera);
    await _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.inkColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Full Body Photo',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).animate().fadeIn(),
              const SizedBox(height: 8),
              Text(
                'This helps us create accurate virtual try-ons',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.inkColor.withOpacity(0.6),
                    ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 24),
              
              // Camera View
              Expanded(
                child: GlassContainer(
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radiusL - 2),
                    child: _isCameraInitialized && _cameraController != null
                        ? Stack(
                            children: [
                              CameraPreview(_cameraController!),
                              // Overlay guide
                              CustomPaint(
                                size: Size.infinite,
                                painter: _BodyOutlinePainter(),
                              ),
                              // Camera switch button
                              Positioned(
                                top: 16,
                                right: 16,
                                child: IconButton(
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.cameraswitch,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: _switchCamera,
                                ),
                              ),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms),
              
              const SizedBox(height: 16),
              
              // Instructions
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingM),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Stand against a plain background and fit your whole body in the frame',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.inkColor.withOpacity(0.7),
                            ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms),
              
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.offAllNamed(AppRoutes.HOME),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusM),
                        ),
                      ),
                      child: const Text('Skip'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_cameraController != null) {
                          try {
                            final image = await _cameraController!.takePicture();
                            // Process image
                            Get.offAllNamed(AppRoutes.HOME);
                          } catch (e) {
                            print('Error taking picture: $e');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusM),
                        ),
                      ),
                      child: const Text('Take Photo'),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}

class _BodyOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    // Draw body outline guide
    final path = Path();
    
    // Head
    path.addOval(Rect.fromCenter(
      center: Offset(centerX, centerY - size.height * 0.35),
      width: size.width * 0.15,
      height: size.height * 0.1,
    ));
    
    // Body
    path.moveTo(centerX - size.width * 0.12, centerY - size.height * 0.28);
    path.lineTo(centerX - size.width * 0.15, centerY + size.height * 0.05);
    path.lineTo(centerX - size.width * 0.1, centerY + size.height * 0.4);
    
    path.moveTo(centerX + size.width * 0.12, centerY - size.height * 0.28);
    path.lineTo(centerX + size.width * 0.15, centerY + size.height * 0.05);
    path.lineTo(centerX + size.width * 0.1, centerY + size.height * 0.4);
    
    // Arms
    path.moveTo(centerX - size.width * 0.12, centerY - size.height * 0.2);
    path.lineTo(centerX - size.width * 0.25, centerY);
    
    path.moveTo(centerX + size.width * 0.12, centerY - size.height * 0.2);
    path.lineTo(centerX + size.width * 0.25, centerY);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BodyOutlinePainter oldDelegate) => false;
}

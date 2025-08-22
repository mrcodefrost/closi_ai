import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  bool _cameraGranted = false;
  bool _galleryGranted = false;
  bool _notificationsGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final camera = await Permission.camera.isGranted;
    final photos = await Permission.photos.isGranted;
    final notifications = await Permission.notification.isGranted;
    
    setState(() {
      _cameraGranted = camera;
      _galleryGranted = photos;
      _notificationsGranted = notifications;
    });
  }

  Future<void> _requestPermission(Permission permission, Function(bool) onResult) async {
    final status = await permission.request();
    onResult(status.isGranted);
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
                'Permissions',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).animate().fadeIn(),
              const SizedBox(height: 8),
              Text(
                'Closi needs these permissions to work properly',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.inkColor.withOpacity(0.6),
                    ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 40),
              _buildPermissionTile(
                context,
                Icons.camera_alt_outlined,
                'Camera',
                'Take photos of your clothes',
                _cameraGranted,
                () => _requestPermission(
                  Permission.camera,
                  (granted) => setState(() => _cameraGranted = granted),
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 16),
              _buildPermissionTile(
                context,
                Icons.photo_library_outlined,
                'Photo Library',
                'Import existing photos',
                _galleryGranted,
                () => _requestPermission(
                  Permission.photos,
                  (granted) => setState(() => _galleryGranted = granted),
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 16),
              _buildPermissionTile(
                context,
                Icons.notifications_outlined,
                'Notifications',
                'Get outfit suggestions & reminders',
                _notificationsGranted,
                () => _requestPermission(
                  Permission.notification,
                  (granted) => setState(() => _notificationsGranted = granted),
                ),
              ).animate().fadeIn(delay: 400.ms),
              const Spacer(),
              ElevatedButton(
                onPressed: (_cameraGranted || _galleryGranted)
                    ? () => Get.toNamed(AppRoutes.STYLE_PICKER)
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                ),
                child: const Text('Continue'),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.STYLE_PICKER),
                child: Text(
                  'Skip for now',
                  style: TextStyle(
                    color: AppTheme.inkColor.withOpacity(0.6),
                  ),
                ),
              ).animate().fadeIn(delay: 600.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool isGranted,
    VoidCallback onRequest,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppTheme.paddingM),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isGranted
                  ? Colors.green.withOpacity(0.1)
                  : AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Icon(
              icon,
              color: isGranted ? Colors.green : AppTheme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.inkColor.withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: isGranted ? null : onRequest,
            child: Text(isGranted ? 'Granted' : 'Allow'),
          ),
        ],
      ),
    );
  }
}

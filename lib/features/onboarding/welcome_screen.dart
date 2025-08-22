import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.accentColor.withOpacity(0.1),
                      AppTheme.primaryColor.withOpacity(0.05),
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.style_outlined,
                  size: 80,
                  color: AppTheme.primaryColor,
                ),
              ).animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 40),
              Text(
                'Welcome to Closi',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).animate()
                  .fadeIn(delay: 200.ms),
              const SizedBox(height: 16),
              Text(
                'Your personal AI stylist and\ndigital wardrobe assistant',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.inkColor.withOpacity(0.7),
                      height: 1.5,
                    ),
              ).animate()
                  .fadeIn(delay: 400.ms),
              const SizedBox(height: 48),
              _buildFeature(
                context,
                Icons.camera_alt_outlined,
                'Digitize Your Wardrobe',
                'Capture and organize all your clothes',
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 16),
              _buildFeature(
                context,
                Icons.auto_awesome,
                'AI-Powered Styling',
                'Get personalized outfit recommendations',
              ).animate().fadeIn(delay: 800.ms),
              const SizedBox(height: 16),
              _buildFeature(
                context,
                Icons.view_in_ar,
                'Virtual Try-On',
                'See how outfits look before wearing',
              ).animate().fadeIn(delay: 1000.ms),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.AUTH),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                ),
                child: const Text('Get Started'),
              ).animate()
                  .fadeIn(delay: 1200.ms)
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.offAllNamed(AppRoutes.HOME),
                child: Text(
                  'Skip for now',
                  style: TextStyle(
                    color: AppTheme.inkColor.withOpacity(0.6),
                  ),
                ),
              ).animate()
                  .fadeIn(delay: 1400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppTheme.paddingM),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusS),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
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
        ],
      ),
    );
  }
}

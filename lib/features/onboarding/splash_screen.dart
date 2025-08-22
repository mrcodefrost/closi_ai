import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRoutes.ONBOARDING);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.bgColor,
                  AppTheme.bgColor.withOpacity(0.8),
                  Colors.white.withOpacity(0.5),
                ],
              ),
            ),
          ),
          // Frosted glass overlay
          Center(
            child: GlassContainer(
              width: 280,
              height: 280,
              borderRadius: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.checkroom_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ).animate()
                      .fadeIn(duration: 600.ms)
                      .scale(delay: 300.ms),
                  const SizedBox(height: 24),
                  Text(
                    'CLOSI',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          letterSpacing: 4,
                          fontWeight: FontWeight.w700,
                        ),
                  ).animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 8),
                  Text(
                    'Your AI Stylist',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.inkColor.withOpacity(0.6),
                          letterSpacing: 1,
                        ),
                  ).animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

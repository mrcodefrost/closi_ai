import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _showOtpField = false;

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
                'Sign In',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).animate().fadeIn(),
              const SizedBox(height: 8),
              Text(
                'Enter your phone number to continue',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.inkColor.withOpacity(0.6),
                    ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 40),
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingL),
                child: Column(
                  children: [
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                    ),
                    if (_showOtpField) ...[
                      const SizedBox(height: 16),
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter OTP',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                      ).animate().fadeIn(),
                    ],
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (!_showOtpField) {
                          setState(() => _showOtpField = true);
                        } else {
                          Get.toNamed(AppRoutes.PERMISSIONS);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: Text(_showOtpField ? 'Verify OTP' : 'Send OTP'),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'OR',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.inkColor.withOpacity(0.5),
                      ),
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 32),
              _buildSocialButton(
                'Continue with Google',
                Icons.g_mobiledata,
                () => Get.toNamed(AppRoutes.PERMISSIONS),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 16),
              _buildSocialButton(
                'Continue with Apple',
                Icons.apple,
                () => Get.toNamed(AppRoutes.PERMISSIONS),
              ).animate().fadeIn(delay: 500.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingL,
          vertical: AppTheme.paddingM,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: AppTheme.inkColor),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.inkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }
}

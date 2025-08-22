import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkMode = false;
  bool _autoBackup = true;
  bool _aiRecommendations = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Account Settings
              const Text(
                'Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(),
              const SizedBox(height: 16),
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingM),
                child: Column(
                  children: [
                    _buildSettingTile(
                      Icons.person_outline,
                      'Edit Profile',
                      'Update your personal information',
                      onTap: () {},
                    ),
                    _buildSettingTile(
                      Icons.lock_outline,
                      'Change Password',
                      'Update your security settings',
                      onTap: () {},
                    ),
                    _buildSettingTile(
                      Icons.email_outlined,
                      'Email Preferences',
                      'Manage email notifications',
                      onTap: () {},
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 24),

              // App Preferences
              const Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 16),
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingM),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      Icons.notifications_outlined,
                      'Push Notifications',
                      'Get updates about your outfits',
                      _notificationsEnabled,
                      (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                    _buildSwitchTile(
                      Icons.dark_mode_outlined,
                      'Dark Mode',
                      'Switch to dark theme',
                      _darkMode,
                      (value) {
                        setState(() {
                          _darkMode = value;
                        });
                      },
                    ),
                    _buildSwitchTile(
                      Icons.psychology_outlined,
                      'AI Recommendations',
                      'Get personalized style suggestions',
                      _aiRecommendations,
                      (value) {
                        setState(() {
                          _aiRecommendations = value;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.language_outlined),
                      title: const Text('Language'),
                      subtitle: Text(_selectedLanguage),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        _showLanguageDialog();
                      },
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 24),

              // Data & Storage
              const Text(
                'Data & Storage',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 16),
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingM),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      Icons.backup_outlined,
                      'Auto Backup',
                      'Automatically backup your wardrobe',
                      _autoBackup,
                      (value) {
                        setState(() {
                          _autoBackup = value;
                        });
                      },
                    ),
                    _buildSettingTile(
                      Icons.download_outlined,
                      'Export Data',
                      'Download your wardrobe data',
                      onTap: () {
                        Get.snackbar(
                          'Export Started',
                          'Your data is being prepared for download',
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
                          colorText: Colors.white,
                        );
                      },
                    ),
                    _buildSettingTile(
                      Icons.cleaning_services_outlined,
                      'Clear Cache',
                      'Free up storage space',
                      onTap: () {
                        Get.snackbar(
                          'Cache Cleared',
                          'Successfully cleared 125 MB',
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
                          colorText: Colors.white,
                        );
                      },
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 24),

              // About & Legal
              const Text(
                'About & Legal',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 16),
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingM),
                child: Column(
                  children: [
                    _buildSettingTile(
                      Icons.info_outline,
                      'About Closi',
                      'Version 1.0.0',
                      onTap: () {},
                    ),
                    _buildSettingTile(
                      Icons.description_outlined,
                      'Terms of Service',
                      'Read our terms',
                      onTap: () {},
                    ),
                    _buildSettingTile(
                      Icons.privacy_tip_outlined,
                      'Privacy Policy',
                      'Learn how we protect your data',
                      onTap: () {},
                    ),
                    _buildSettingTile(
                      Icons.star_outline,
                      'Rate Us',
                      'Share your feedback',
                      onTap: () {},
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 700.ms),
              const SizedBox(height: 24),

              // Danger Zone
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingL),
                borderColor: Colors.red.withOpacity(0.3),
                child: Column(
                  children: [
                    const Text(
                      'Danger Zone',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        _showDeleteAccountDialog();
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        side: BorderSide(color: Colors.red.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusM),
                        ),
                      ),
                      child: const Text(
                        'Delete Account',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.inkColor.withOpacity(0.6),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.inkColor.withOpacity(0.6),
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
        ),
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            'English',
            'Spanish',
            'French',
            'German',
            'Chinese',
          ].map((lang) => ListTile(
            title: Text(lang),
            trailing: _selectedLanguage == lang 
                ? const Icon(Icons.check, color: AppTheme.primaryColor)
                : null,
            onTap: () {
              setState(() {
                _selectedLanguage = lang;
              });
              Get.back();
            },
          )).toList(),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
        ),
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Account Deletion',
                'Your request has been submitted',
                backgroundColor: Colors.red.withOpacity(0.9),
                colorText: Colors.white,
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

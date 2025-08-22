import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Get.toNamed(AppRoutes.SETTINGS),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.paddingL),
          child: Column(
            children: [
              // Profile Header
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingL),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.primaryColor.withOpacity(0.8),
                            AppTheme.secondaryColor.withOpacity(0.8),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ).animate().scale(),
                    const SizedBox(height: 16),
                    const Text(
                      'Fashion Enthusiast',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(delay: 100.ms),
                    const SizedBox(height: 8),
                    Text(
                      '@stylish_user',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.inkColor.withOpacity(0.6),
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                    const SizedBox(height: 20),
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem('Items', '128'),
                        _buildStatItem('Outfits', '45'),
                        _buildStatItem('Saved', '89'),
                      ],
                    ).animate().fadeIn(delay: 300.ms),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Body Profile Section
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Body Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildProfileItem(Icons.person_outline, 'Gender', 'Female'),
                    _buildProfileItem(Icons.straighten, 'Height', '5\'6"'),
                    _buildProfileItem(Icons.fitness_center, 'Weight', '130 lbs'),
                    _buildProfileItem(Icons.accessibility_new, 'Body Type', 'Athletic'),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 24),

              // Style Preferences
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Style Preferences',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Edit'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        'Casual',
                        'Business',
                        'Sporty',
                        'Elegant',
                        'Minimalist',
                      ].map((style) => Chip(
                        label: Text(style),
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        side: BorderSide(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 24),

              // Quick Actions
              GlassContainer(
                padding: const EdgeInsets.all(AppTheme.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildActionTile(
                      Icons.favorite_outline,
                      'Favorites',
                      'View your favorite items',
                      () {},
                    ),
                    _buildActionTile(
                      Icons.history,
                      'Outfit History',
                      'See your past outfits',
                      () {},
                    ),
                    _buildActionTile(
                      Icons.share_outlined,
                      'Share Profile',
                      'Share your style with friends',
                      () {},
                    ),
                    _buildActionTile(
                      Icons.help_outline,
                      'Help & Support',
                      'Get assistance',
                      () {},
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 24),

              // Sign Out Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.WELCOME);
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusM),
                    ),
                    side: BorderSide(
                      color: Colors.red.withOpacity(0.5),
                    ),
                  ),
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ).animate().fadeIn(delay: 700.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.inkColor.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.inkColor.withOpacity(0.6)),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.inkColor.withOpacity(0.6),
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
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
}

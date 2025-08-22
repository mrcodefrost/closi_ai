import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class StylePickerScreen extends StatefulWidget {
  const StylePickerScreen({super.key});

  @override
  State<StylePickerScreen> createState() => _StylePickerScreenState();
}

class _StylePickerScreenState extends State<StylePickerScreen> {
  final List<String> _selectedStyles = [];
  
  final List<Map<String, dynamic>> _styles = [
    {'name': 'Minimalist', 'icon': Icons.square_outlined, 'color': Colors.grey},
    {'name': 'Classic', 'icon': Icons.watch, 'color': Colors.brown},
    {'name': 'Casual', 'icon': Icons.weekend, 'color': Colors.blue},
    {'name': 'Business', 'icon': Icons.business_center, 'color': Colors.black},
    {'name': 'Streetwear', 'icon': Icons.skateboarding, 'color': Colors.orange},
    {'name': 'Bohemian', 'icon': Icons.local_florist, 'color': Colors.pink},
    {'name': 'Sporty', 'icon': Icons.sports_tennis, 'color': Colors.green},
    {'name': 'Elegant', 'icon': Icons.diamond, 'color': Colors.purple},
    {'name': 'Vintage', 'icon': Icons.access_time, 'color': Colors.amber},
    {'name': 'Edgy', 'icon': Icons.flash_on, 'color': Colors.red},
    {'name': 'Romantic', 'icon': Icons.favorite, 'color': Colors.pink},
    {'name': 'Avant-garde', 'icon': Icons.architecture, 'color': Colors.indigo},
  ];

  void _toggleStyle(String style) {
    setState(() {
      if (_selectedStyles.contains(style)) {
        _selectedStyles.remove(style);
      } else {
        _selectedStyles.add(style);
      }
    });
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
                'Your Style',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).animate().fadeIn(),
              const SizedBox(height: 8),
              Text(
                'Select styles that resonate with you',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.inkColor.withOpacity(0.6),
                    ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 32),
              Expanded(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _styles.map((style) {
                    final isSelected = _selectedStyles.contains(style['name']);
                    return _buildStyleChip(
                      style['name'],
                      style['icon'],
                      style['color'],
                      isSelected,
                      () => _toggleStyle(style['name']),
                    ).animate().fadeIn(
                      delay: Duration(milliseconds: 100 + _styles.indexOf(style) * 50),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _selectedStyles.isNotEmpty
                    ? () => Get.toNamed(AppRoutes.BODY_PROFILE)
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                ),
                child: Text(
                  _selectedStyles.isEmpty
                      ? 'Select at least one style'
                      : 'Continue (${_selectedStyles.length} selected)',
                ),
              ).animate().fadeIn(delay: 800.ms),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.BODY_PROFILE),
                child: Text(
                  'Skip for now',
                  style: TextStyle(
                    color: AppTheme.inkColor.withOpacity(0.6),
                  ),
                ),
              ).animate().fadeIn(delay: 900.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyleChip(
    String label,
    IconData icon,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.2)
              : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : AppTheme.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? color : AppTheme.inkColor.withOpacity(0.6),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? color : AppTheme.inkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

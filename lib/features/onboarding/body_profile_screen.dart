import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class BodyProfileScreen extends StatefulWidget {
  const BodyProfileScreen({super.key});

  @override
  State<BodyProfileScreen> createState() => _BodyProfileScreenState();
}

class _BodyProfileScreenState extends State<BodyProfileScreen> {
  String _selectedGender = '';
  String _selectedBodyType = '';
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  final List<String> _bodyTypes = [
    'Rectangle',
    'Triangle',
    'Inverted Triangle',
    'Hourglass',
    'Apple',
    'Pear',
  ];

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Body Profile',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ).animate().fadeIn(),
              const SizedBox(height: 8),
              Text(
                'Help us personalize your recommendations',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.inkColor.withOpacity(0.6),
                    ),
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 32),
              
              // Gender Selection
              Text(
                'Gender',
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildGenderOption('Male', Icons.male),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildGenderOption('Female', Icons.female),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildGenderOption('Other', Icons.transgender),
                  ),
                ],
              ).animate().fadeIn(delay: 300.ms),
              
              const SizedBox(height: 32),
              
              // Body Type
              Text(
                'Body Type',
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _bodyTypes.map((type) {
                  return ChoiceChip(
                    label: Text(type),
                    selected: _selectedBodyType == type,
                    onSelected: (selected) {
                      setState(() => _selectedBodyType = selected ? type : '');
                    },
                  );
                }).toList(),
              ).animate().fadeIn(delay: 500.ms),
              
              const SizedBox(height: 32),
              
              // Height and Weight
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Height (cm)',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        GlassContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '170',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weight (kg)',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        GlassContainer(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextField(
                            controller: _weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '70',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms),
              
              const SizedBox(height: 48),
              
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.FULL_BODY_PHOTO),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                  ),
                ),
                child: const Text('Continue'),
              ).animate().fadeIn(delay: 700.ms),
              
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.offAllNamed(AppRoutes.HOME),
                child: Text(
                  'Skip and start exploring',
                  style: TextStyle(
                    color: AppTheme.inkColor.withOpacity(0.6),
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon) {
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryColor.withOpacity(0.1)
              : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? AppTheme.primaryColor : AppTheme.inkColor.withOpacity(0.6),
            ),
            const SizedBox(height: 8),
            Text(
              gender,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppTheme.primaryColor : AppTheme.inkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }
}

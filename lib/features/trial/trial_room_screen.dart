import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class TrialRoomScreen extends StatefulWidget {
  const TrialRoomScreen({super.key});

  @override
  State<TrialRoomScreen> createState() => _TrialRoomScreenState();
}

class _TrialRoomScreenState extends State<TrialRoomScreen> {
  String _selectedAvatar = 'avatar1';
  String? _selectedOutfit;
  bool _showAR = false;

  final List<Map<String, dynamic>> _avatars = [
    {'id': 'avatar1', 'name': 'Classic', 'icon': '👤'},
    {'id': 'avatar2', 'name': 'Athletic', 'icon': '🏃'},
    {'id': 'avatar3', 'name': 'Casual', 'icon': '😎'},
    {'id': 'avatar4', 'name': 'Professional', 'icon': '💼'},
  ];

  final List<Map<String, dynamic>> _outfits = [
    {'id': 'outfit1', 'name': 'Casual Friday', 'items': ['👔', '👖', '👟']},
    {'id': 'outfit2', 'name': 'Business Meeting', 'items': ['👔', '👖', '👞']},
    {'id': 'outfit3', 'name': 'Weekend Vibes', 'items': ['👕', '👖', '👟']},
    {'id': 'outfit4', 'name': 'Date Night', 'items': ['👔', '👖', '👞', '⌚']},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Trial Room'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(_showAR ? Icons.view_in_ar : Icons.view_in_ar_outlined),
            onPressed: () {
              setState(() {
                _showAR = !_showAR;
              });
              if (_showAR) {
                Get.snackbar(
                  'AR Mode',
                  'Augmented Reality view activated',
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP,
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {
              Get.snackbar(
                'Screenshot Saved',
                'Your look has been saved to gallery',
                backgroundColor: AppTheme.primaryColor.withOpacity(0.9),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Avatar Display Area
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.all(AppTheme.paddingL),
                child: GlassContainer(
                  padding: const EdgeInsets.all(AppTheme.paddingL),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Avatar View
                      Container(
                        width: 200,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(AppTheme.radiusL),
                          border: Border.all(
                            color: _showAR ? AppTheme.primaryColor : AppTheme.borderColor,
                            width: _showAR ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Avatar Icon
                            Text(
                              _avatars.firstWhere((a) => a['id'] == _selectedAvatar)['icon'],
                              style: const TextStyle(fontSize: 80),
                            ).animate().scale(
                              begin: const Offset(0.8, 0.8),
                              end: const Offset(1, 1),
                              duration: 300.ms,
                            ),
                            const SizedBox(height: 20),
                            // Outfit Display
                            if (_selectedOutfit != null) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _outfits
                                    .firstWhere((o) => o['id'] == _selectedOutfit)['items']
                                    .map<Widget>((item) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: Text(
                                            item,
                                            style: const TextStyle(fontSize: 24),
                                          ),
                                        ))
                                    .toList(),
                              ).animate().fadeIn(),
                              const SizedBox(height: 8),
                              Text(
                                _outfits.firstWhere((o) => o['id'] == _selectedOutfit)['name'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ).animate().fadeIn(),
                      const SizedBox(height: 20),
                      // View Controls
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.rotate_left),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.zoom_in),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.zoom_out),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.rotate_right),
                            onPressed: () {},
                          ),
                        ],
                      ).animate().fadeIn(delay: 200.ms),
                    ],
                  ),
                ),
              ),
            ),
            
            // Controls Area
            Container(
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppTheme.borderColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Avatar Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Avatar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _avatars.length,
                            itemBuilder: (context, index) {
                              final avatar = _avatars[index];
                              final isSelected = _selectedAvatar == avatar['id'];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedAvatar = avatar['id'];
                                  });
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppTheme.primaryColor.withOpacity(0.2)
                                        : Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusM),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppTheme.primaryColor
                                          : AppTheme.borderColor,
                                      width: isSelected ? 2 : 1,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(avatar['icon'], style: const TextStyle(fontSize: 20)),
                                      Text(
                                        avatar['name'],
                                        style: const TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Outfit Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingL),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Select Outfit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.toNamed(AppRoutes.OUTFIT_BUILDER),
                              child: const Text('Create New'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _outfits.length,
                            itemBuilder: (context, index) {
                              final outfit = _outfits[index];
                              final isSelected = _selectedOutfit == outfit['id'];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedOutfit = outfit['id'];
                                  });
                                },
                                child: GlassContainer(
                                  width: 120,
                                  margin: const EdgeInsets.only(right: 12),
                                  padding: const EdgeInsets.all(8),
                                  borderWidth: isSelected ? 2 : 1,
                                  borderColor: isSelected
                                      ? AppTheme.primaryColor
                                      : AppTheme.borderColor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: (outfit['items'] as List)
                                            .take(3)
                                            .map<Widget>((item) => Text(
                                                  item,
                                                  style: const TextStyle(fontSize: 16),
                                                ))
                                            .toList(),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        outfit['name'],
                                        style: const TextStyle(fontSize: 10),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.TRIAL_HIFI),
        backgroundColor: AppTheme.primaryColor,
        label: const Text('Try Hi-Fi Mode'),
        icon: const Icon(Icons.high_quality),
      ),
    );
  }
}

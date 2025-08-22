import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../core/widgets/orb_navigation.dart';
import '../../core/widgets/pinned_tray.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _pinnedItems = [];
  int _selectedNavIndex = 0;

  final List<Map<String, dynamic>> _recommendations = [
    {'title': 'Casual Friday', 'items': 4, 'color': Colors.blue},
    {'title': 'Date Night', 'items': 3, 'color': Colors.pink},
    {'title': 'Business Meeting', 'items': 5, 'color': Colors.grey},
    {'title': 'Weekend Brunch', 'items': 3, 'color': Colors.orange},
  ];

  final List<Map<String, dynamic>> _recentItems = [
    {'name': 'White Shirt', 'type': 'Top', 'image': '👔'},
    {'name': 'Blue Jeans', 'type': 'Bottom', 'image': '👖'},
    {'name': 'Black Blazer', 'type': 'Outerwear', 'image': '🧥'},
    {'name': 'Sneakers', 'type': 'Shoes', 'image': '👟'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  floating: true,
                  title: Text(
                    'CLOSI',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search, color: AppTheme.inkColor),
                      onPressed: () => Get.toNamed(AppRoutes.SEARCH),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today_outlined, color: AppTheme.inkColor),
                      onPressed: () => Get.toNamed(AppRoutes.PLANNER),
                    ),
                  ],
                ),
                
                // Content
                SliverPadding(
                  padding: const EdgeInsets.all(AppTheme.paddingL),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Welcome Message
                      _buildWelcomeSection(context),
                      const SizedBox(height: 32),
                      
                      // Quick Actions
                      _buildQuickActions(context),
                      const SizedBox(height: 32),
                      
                      // AI Recommendations
                      Text(
                        'AI Stylist Picks',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ).animate().fadeIn(delay: 300.ms),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _recommendations.length,
                          itemBuilder: (context, index) {
                            final rec = _recommendations[index];
                            return _buildRecommendationCard(
                              rec['title'],
                              rec['items'],
                              rec['color'],
                            ).animate().fadeIn(
                              delay: Duration(milliseconds: 400 + index * 100),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Recent Items
                      Text(
                        'Recent Wardrobe',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ).animate().fadeIn(delay: 600.ms),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: _recentItems.length,
                        itemBuilder: (context, index) {
                          final item = _recentItems[index];
                          return _buildItemCard(
                            item['name'],
                            item['type'],
                            item['image'],
                          ).animate().fadeIn(
                            delay: Duration(milliseconds: 700 + index * 100),
                          );
                        },
                      ),
                      const SizedBox(height: 100), // Space for navigation
                    ]),
                  ),
                ),
              ],
            ),
          ),
          
          // Pinned Tray
          if (_pinnedItems.isNotEmpty)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: PinnedTray(
                items: _pinnedItems,
                onViewOutfit: () {
                  Get.toNamed(AppRoutes.OUTFIT_BUILDER);
                },
              ),
            ),
          
          // Orb Navigation
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: OrbNavigation(
              selectedIndex: _selectedNavIndex,
              onIndexChanged: (index) {
                setState(() => _selectedNavIndex = index);
                switch (index) {
                  case 0:
                    break; // Already on home
                  case 1:
                    Get.toNamed(AppRoutes.OUTFITS);
                    break;
                  case 2:
                    Get.toNamed(AppRoutes.TRIAL_ROOM);
                    break;
                  case 3:
                    Get.toNamed(AppRoutes.PROFILE);
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(AppTheme.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.accentColor],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good ${_getTimeOfDay()}!',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'What would you like to wear today?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.inkColor.withOpacity(0.6),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            context,
            Icons.add_a_photo,
            'Add Item',
            AppTheme.primaryColor,
            () => Get.toNamed(AppRoutes.ADD_ITEM),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            context,
            Icons.auto_fix_high,
            'Build Outfit',
            AppTheme.accentColor,
            () => Get.toNamed(AppRoutes.OUTFIT_BUILDER),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms);
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(AppTheme.paddingM),
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(String title, int items, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      child: GlassContainer(
        padding: const EdgeInsets.all(AppTheme.paddingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
              ),
              child: Icon(
                Icons.style,
                color: color,
                size: 20,
              ),
            ),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$items items',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.inkColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(String name, String type, String emoji) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_pinnedItems.contains(name)) {
            _pinnedItems.remove(name);
          } else {
            _pinnedItems.add(name);
          }
        });
      },
      child: GlassContainer(
        padding: const EdgeInsets.all(AppTheme.paddingM),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              type,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.inkColor.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            if (_pinnedItems.contains(name))
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Pinned',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';
    return 'Evening';
  }
}

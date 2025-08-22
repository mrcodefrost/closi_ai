import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';

class OutfitBuilderScreen extends StatefulWidget {
  const OutfitBuilderScreen({super.key});

  @override
  State<OutfitBuilderScreen> createState() => _OutfitBuilderScreenState();
}

class _OutfitBuilderScreenState extends State<OutfitBuilderScreen> {
  String? _selectedTop;
  String? _selectedBottom;
  String? _selectedShoes;
  String? _selectedBag;
  String? _selectedAccessory;
  
  final List<Map<String, dynamic>> _wardrobeItems = [
    {'id': '1', 'name': 'White Shirt', 'category': 'Tops', 'emoji': '👔'},
    {'id': '2', 'name': 'Black T-Shirt', 'category': 'Tops', 'emoji': '👕'},
    {'id': '3', 'name': 'Blue Jeans', 'category': 'Bottoms', 'emoji': '👖'},
    {'id': '4', 'name': 'Black Pants', 'category': 'Bottoms', 'emoji': '👖'},
    {'id': '5', 'name': 'Sneakers', 'category': 'Shoes', 'emoji': '👟'},
    {'id': '6', 'name': 'Dress Shoes', 'category': 'Shoes', 'emoji': '👞'},
    {'id': '7', 'name': 'Tote Bag', 'category': 'Bags', 'emoji': '👜'},
    {'id': '8', 'name': 'Backpack', 'category': 'Bags', 'emoji': '🎒'},
    {'id': '9', 'name': 'Watch', 'category': 'Accessories', 'emoji': '⌚'},
    {'id': '10', 'name': 'Sunglasses', 'category': 'Accessories', 'emoji': '🕶️'},
  ];

  List<Map<String, dynamic>> _getItemsByCategory(String category) {
    return _wardrobeItems.where((item) => item['category'] == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Outfit Builder'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_outlined),
            onPressed: () {
              // Save outfit
              Get.snackbar(
                'Outfit Saved',
                'Your outfit has been saved to library',
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
            // Canvas Area
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(AppTheme.paddingL),
                child: GlassContainer(
                  padding: const EdgeInsets.all(AppTheme.paddingL),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Top
                      _buildCanvasSlot(
                        'Top',
                        _selectedTop,
                        Icons.checkroom,
                      ).animate().fadeIn(),
                      const SizedBox(height: 16),
                      // Bottom
                      _buildCanvasSlot(
                        'Bottom',
                        _selectedBottom,
                        Icons.straighten,
                      ).animate().fadeIn(delay: 100.ms),
                      const SizedBox(height: 16),
                      // Shoes
                      _buildCanvasSlot(
                        'Shoes',
                        _selectedShoes,
                        Icons.directions_walk,
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 16),
                      // Accessories Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _buildCanvasSlot(
                              'Bag',
                              _selectedBag,
                              Icons.shopping_bag,
                              isSmall: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildCanvasSlot(
                              'Accessory',
                              _selectedAccessory,
                              Icons.watch,
                              isSmall: true,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 300.ms),
                    ],
                  ),
                ),
              ),
            ),
            
            // Item Selector
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
                  // Category Tabs
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingL),
                      children: [
                        _buildCategoryTab('Tops', Icons.checkroom),
                        _buildCategoryTab('Bottoms', Icons.straighten),
                        _buildCategoryTab('Shoes', Icons.directions_walk),
                        _buildCategoryTab('Bags', Icons.shopping_bag),
                        _buildCategoryTab('Accessories', Icons.watch),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Items Grid
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: AppTheme.paddingL),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1,
                      ),
                      itemCount: _wardrobeItems.length,
                      itemBuilder: (context, index) {
                        final item = _wardrobeItems[index];
                        return _buildItemTile(item);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCanvasSlot(String label, String? selectedItem, IconData icon, {bool isSmall = false}) {
    final size = isSmall ? 80.0 : 100.0;
    final emoji = selectedItem != null
        ? _wardrobeItems.firstWhere((item) => item['name'] == selectedItem)['emoji']
        : null;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: selectedItem != null ? AppTheme.primaryColor : AppTheme.borderColor,
          width: selectedItem != null ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (emoji != null)
            Text(emoji, style: TextStyle(fontSize: isSmall ? 24 : 32))
          else
            Icon(
              icon,
              size: isSmall ? 24 : 32,
              color: AppTheme.inkColor.withOpacity(0.3),
            ),
          const SizedBox(height: 4),
          Text(
            selectedItem ?? label,
            style: TextStyle(
              fontSize: isSmall ? 10 : 12,
              color: selectedItem != null ? AppTheme.inkColor : AppTheme.inkColor.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        selected: false,
        onSelected: (selected) {},
      ),
    );
  }

  Widget _buildItemTile(Map<String, dynamic> item) {
    bool isSelected = false;
    switch (item['category']) {
      case 'Tops':
        isSelected = _selectedTop == item['name'];
        break;
      case 'Bottoms':
        isSelected = _selectedBottom == item['name'];
        break;
      case 'Shoes':
        isSelected = _selectedShoes == item['name'];
        break;
      case 'Bags':
        isSelected = _selectedBag == item['name'];
        break;
      case 'Accessories':
        isSelected = _selectedAccessory == item['name'];
        break;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          switch (item['category']) {
            case 'Tops':
              _selectedTop = isSelected ? null : item['name'];
              break;
            case 'Bottoms':
              _selectedBottom = isSelected ? null : item['name'];
              break;
            case 'Shoes':
              _selectedShoes = isSelected ? null : item['name'];
              break;
            case 'Bags':
              _selectedBag = isSelected ? null : item['name'];
              break;
            case 'Accessories':
              _selectedAccessory = isSelected ? null : item['name'];
              break;
          }
        });
      },
      child: GlassContainer(
        padding: const EdgeInsets.all(8),
        borderWidth: isSelected ? 2 : 1,
        borderColor: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item['emoji'], style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              item['name'],
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/glass_container.dart';
import '../../routes/app_routes.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String _selectedCategory = '';
  String _selectedColor = '';
  String _selectedBrand = '';
  final _brandController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Tops', 'icon': Icons.checkroom},
    {'name': 'Bottoms', 'icon': Icons.straighten},
    {'name': 'Dresses', 'icon': Icons.woman},
    {'name': 'Outerwear', 'icon': Icons.ac_unit},
    {'name': 'Shoes', 'icon': Icons.directions_walk},
    {'name': 'Bags', 'icon': Icons.shopping_bag},
    {'name': 'Accessories', 'icon': Icons.watch},
    {'name': 'Other', 'icon': Icons.category},
  ];

  final List<Map<String, dynamic>> _colors = [
    {'name': 'Black', 'color': Colors.black},
    {'name': 'White', 'color': Colors.white},
    {'name': 'Grey', 'color': Colors.grey},
    {'name': 'Navy', 'color': Colors.indigo},
    {'name': 'Blue', 'color': Colors.blue},
    {'name': 'Red', 'color': Colors.red},
    {'name': 'Pink', 'color': Colors.pink},
    {'name': 'Green', 'color': Colors.green},
    {'name': 'Yellow', 'color': Colors.yellow},
    {'name': 'Orange', 'color': Colors.orange},
    {'name': 'Purple', 'color': Colors.purple},
    {'name': 'Brown', 'color': Colors.brown},
  ];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        borderRadius: 20,
        padding: const EdgeInsets.all(AppTheme.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Get.back();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Item'),
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
              // Image Section
              GestureDetector(
                onTap: _showImageSourceDialog,
                child: GlassContainer(
                  width: double.infinity,
                  height: 300,
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(AppTheme.radiusL),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 64,
                              color: AppTheme.primaryColor.withOpacity(0.6),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tap to add photo',
                              style: TextStyle(
                                color: AppTheme.inkColor.withOpacity(0.6),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                ).animate().fadeIn(),
              ),
              const SizedBox(height: 32),

              // Category Selection
              Text(
                'Category',
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categories.map((cat) {
                  final isSelected = _selectedCategory == cat['name'];
                  return FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          cat['icon'],
                          size: 16,
                          color: isSelected
                              ? Colors.white
                              : AppTheme.inkColor.withOpacity(0.6),
                        ),
                        const SizedBox(width: 4),
                        Text(cat['name']),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? cat['name'] : '';
                      });
                    },
                    selectedColor: AppTheme.primaryColor,
                    checkmarkColor: Colors.white,
                  );
                }).toList(),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 24),

              // Color Selection
              Text(
                'Color',
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _colors.length,
                  itemBuilder: (context, index) {
                    final colorData = _colors[index];
                    final isSelected = _selectedColor == colorData['name'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = colorData['name'];
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: colorData['color'],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? AppTheme.primaryColor
                                : AppTheme.borderColor,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 24),

              // Brand Input
              Text(
                'Brand',
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 12),
              GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _brandController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter brand name (optional)',
                  ),
                ),
              ).animate().fadeIn(delay: 600.ms),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusM),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _selectedImage != null && _selectedCategory.isNotEmpty
                          ? () {
                              // Save item and go to tag review
                              Get.toNamed(AppRoutes.TAG_REVIEW);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusM),
                        ),
                      ),
                      child: const Text('Add to Wardrobe'),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 700.ms),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _brandController.dispose();
    super.dispose();
  }
}

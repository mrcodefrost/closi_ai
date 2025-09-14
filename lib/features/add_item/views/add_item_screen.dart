import 'package:ai_closet_flutter/core/services/image_service.dart';
import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/add_item/widgets/add_item_action_tile.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageService = Get.find<ImageService>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                spacing: 10,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_outlined),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      backgroundColor: IconColor.white,
                      foregroundColor: IconColor.brown,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add an item',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Add an item to your closet',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AddItemActionTile(
                title: 'Camera Capture',
                subtitle: 'Take a photo of your item',
                icon: Icons.camera,
                onTap: () async {
                  final image = await imageService.pickFromCamera();
                  if (image != null) {
                    print("✅ Image captured: ${image.path}");
                    // show preview, upload, or save to local DB
                    Get.toNamed(AppRoutes.manualEntry);
                  } else {
                    print("⚠️ No image selected");
                  }
                },
              ),
              const SizedBox(height: 10),
              AddItemActionTile(
                title: 'Gallery',
                subtitle: 'Choose from your gallery',
                icon: Icons.image,
                onTap: () async {
                  final image = await imageService.pickFromGallery();
                  if (image != null) {
                    print("✅ Image selected: ${image.path}");
                    // show preview, upload, or save to local DB
                    Get.toNamed(AppRoutes.manualEntry);
                  } else {
                    print("⚠️ No image selected");
                  }
                },
              ),
              const SizedBox(height: 10),
              AddItemActionTile(
                title: 'Manual Entry',
                subtitle: 'Add items manually with custom details',
                icon: Icons.edit,
                onTap: () {
                  Get.toNamed(AppRoutes.manualEntry);
                },
              ),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: BorderColor.paleBrown),
                  color: BackgroundColor.darkCream,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.diamond_outlined,
                          color: IconColor.camelBrown,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            'Tips for best results',
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: TextColor.camelBrown,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '\u2022  Use good lighting for best results.\n'
                      '\u2022  Lay the item flat for better results.\n'
                      '\u2022  Include brand tags and care labels when possible.\n'
                      '\u2022  Add multiple angles for complex items.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

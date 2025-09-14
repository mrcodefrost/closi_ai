import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/multi_selectable_chips_list.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchTaggingScreen extends StatelessWidget {
  const BatchTaggingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        overlayColor: SplashColor.brown,
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Batch Tagging',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Tag your item',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: BackgroundColor.offWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Tags',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Popular Tags',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      MultiSelectableChipsList<String>(
                        items: ['Casual', 'Formal', 'Beach', 'Winter', 'Party'],
                        labelBuilder: (tag) => tag,
                        onSelectionChanged: (selectedTags) {
                          debugPrint("✅ Selected Tags: $selectedTags");
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                PrimaryButton(
                  width: double.maxFinite,
                  text: 'Save',
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.home);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ai_closet_flutter/core/services/image_service.dart';
import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/features/common/custom_dropdown_menu.dart';
import 'package:ai_closet_flutter/features/common/custom_text_form_field.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManualEntryScreen extends StatelessWidget {
  const ManualEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageService = Get.find<ImageService>();
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
                          'Manual Entry',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Edit item details',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Item Photo',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Material(
                  color: ButtonColor.offWhite,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    splashColor: SplashColor.brown,
                    borderRadius: BorderRadius.circular(
                      20,
                    ), // matches container
                    onTap: () async {
                      final image = await imageService.pickFromGallery();
                      if (image != null) {
                        print("✅ Image selected: ${image.path}");
                        // show preview, upload, or save to local DB
                      } else {
                        print("⚠️ No image selected");
                      }
                    },
                    child: SizedBox(
                      height: 250,
                      width: double.maxFinite,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 50,
                              color: IconColor.lightBlack,
                            ),
                            Text(
                              'Tap to add photo',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Item Name',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(hintText: 'Item name'),
                const SizedBox(height: 20),
                Text(
                  'Brand',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(hintText: 'Brand'),
                const SizedBox(height: 20),
                Text(
                  'Price',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(hintText: 'Price'),
                const SizedBox(height: 20),
                Text(
                  'Category',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                CustomDropDownMenu(
                  items: ['Clothing', 'Shoes', 'Accessories'],
                  itemLabel: (item) => item,
                ),
                const SizedBox(height: 20),
                Text(
                  'Color',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                CustomDropDownMenu(
                  items: ['Red', 'Blue', 'Green'],
                  itemLabel: (item) => item,
                ),
                const SizedBox(height: 20),
                Text(
                  'Size',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                CustomDropDownMenu(
                  items: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
                  itemLabel: (item) => item,
                ),
                const SizedBox(height: 20),
                Text(
                  'Description',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                CustomTextFormField(hintText: 'Description'),
                const SizedBox(height: 30),
                PrimaryButton(
                  width: double.maxFinite,
                  text: 'Next',
                  onPressed: () {
                    Get.toNamed(AppRoutes.batchTagging);
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

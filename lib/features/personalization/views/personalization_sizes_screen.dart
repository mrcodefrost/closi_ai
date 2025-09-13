import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/features/common/custom_dropdown_menu.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalizationSizesScreen extends StatelessWidget {
  const PersonalizationSizesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: Text(
                'Core sizes',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Help us prefilter shopping and create better fit suggestions.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: TextColor.lightBlack),
            ),

            const SizedBox(height: 25),
            Text(
              'Tops',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: TextColor.black,

                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            CustomDropDownMenu(
              hintText: 'Select size',
              items: ['XS', 'S', 'M', 'L', 'XL', '2XL', '3XL'],
              itemLabel: (label) => label,
            ),
            const SizedBox(height: 35),
            Text(
              'Bottoms',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: TextColor.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            CustomDropDownMenu(
              hintText: 'Select size',
              items: ['XS', 'S', 'M', 'L', 'XL', '2XL', '3XL'],
              itemLabel: (label) => label,
            ),
            const SizedBox(height: 35),
            Text(
              'Shoes',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: TextColor.black,

                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            CustomDropDownMenu(
              hintText: 'Select size',
              items: ['5', '6', '7', '8', '9', '10', '11', '12'],
              itemLabel: (label) => label,
            ),
            const SizedBox(height: 35),
            PrimaryButton(
              width: double.maxFinite,
              text: 'Continue',
              onPressed: () {
                Get.toNamed(AppRoutes.personalizationStyle);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalizationGenderScreen extends StatelessWidget {
  const PersonalizationGenderScreen({super.key});

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
                'Who you\'re styling.',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select all that apply to set your default categories.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: TextColor.lightBlack),
            ),

            const SizedBox(height: 25),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: BorderColor.paleBrown),
                color: BackgroundColor.offWhite,
              ),
              child: Row(
                children: [
                  CupertinoSwitch(value: false, onChanged: (val) {}),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                          'Only show my categories',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Filter the app to show only your selected styles.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: BorderColor.paleBrown),
                color: BackgroundColor.darkCream,
              ),
              child: Row(
                children: [
                  Icon(Icons.tune_outlined, color: IconColor.brown, size: 30),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'This sets your default category preferences and influences UI copy throughout the app.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: TextColor.lightBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            PrimaryButton(
              width: double.maxFinite,
              text: 'Continue',
              onPressed: () {
                Get.toNamed(AppRoutes.personalizationSizes);
              },
            ),
          ],
        ),
      ),
    );
  }
}

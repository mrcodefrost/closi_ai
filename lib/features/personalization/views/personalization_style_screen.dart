import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/large_square_button.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalizationStyleScreen extends StatelessWidget {
  const PersonalizationStyleScreen({super.key});

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
                'Style vibes',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Pick upto 3',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: TextColor.camelBrown),
            ),
            const SizedBox(height: 20),
            Text(
              'Choose the aesthetics that resonate with your style.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: TextColor.lightBlack),
            ),
            const SizedBox(height: 30),

            Row(
              spacing: 15,
              children: [
                Flexible(
                  child: LargeSquareButton(
                    icon: Icons.remove_circle_outline,
                    heading: 'Minimal',
                    description: 'Clean, simple aesthetic',
                  ),
                ),
                Flexible(
                  child: LargeSquareButton(
                    icon: Icons.work_outline,
                    heading: 'Smart - Casual',
                    description: 'Professional yet relaxed',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              spacing: 15,
              children: [
                Flexible(
                  child: LargeSquareButton(
                    icon: Icons.stacked_line_chart_sharp,
                    heading: 'Minimal',
                    description: 'Clean, simple aesthetic',
                  ),
                ),
                Flexible(
                  child: LargeSquareButton(
                    icon: Icons.work_outline,
                    heading: 'Smart - Casual',
                    description: 'Professional yet relaxed',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: BorderColor.paleBrown),
                color: BackgroundColor.darkCream,
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: IconColor.brown, size: 30),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'These vibes will guide AI styling suggestions and outfit recommendations.',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: TextColor.lightBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            PrimaryButton(
              width: double.maxFinite,
              text: 'Continue',
              onPressed: () {
                Get.toNamed(AppRoutes.personalizationClimate);
              },
            ),
          ],
        ),
      ),
    );
  }
}

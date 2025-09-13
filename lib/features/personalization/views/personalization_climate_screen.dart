import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/large_square_button.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalizationClimateScreen extends StatelessWidget {
  const PersonalizationClimateScreen({super.key});

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
                'Climate & Routine',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Help us understand your environment and daily needs.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: TextColor.lightBlack),
            ),
            const SizedBox(height: 30),
            Text(
              'Climate',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),

            Row(
              spacing: 5,
              children: [
                Expanded(
                  child: LargeSquareButton(
                    icon: Icons.sunny,
                    heading: 'Hot',
                    description: '',
                  ),
                ),
                Expanded(
                  child: LargeSquareButton(
                    icon: Icons.water_drop,
                    heading: 'Humid',
                    description: '',
                  ),
                ),
                Expanded(
                  child: LargeSquareButton(
                    icon: Icons.thermostat,
                    heading: 'Mild',
                    description: '',
                  ),
                ),
                Expanded(
                  child: LargeSquareButton(
                    icon: Icons.severe_cold_outlined,
                    heading: 'Cold',
                    description: '',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Work dress code',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Text(
              'Smart Casual',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: TextColor.camelBrown),
            ),

            const SizedBox(height: 50),
            PrimaryButton(
              width: double.maxFinite,
              text: 'Continue',
              onPressed: () {
                Get.toNamed(AppRoutes.personalizationPrivacy);
              },
            ),
          ],
        ),
      ),
    );
  }
}

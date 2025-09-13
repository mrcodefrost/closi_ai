import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalizationPrivacyScreen extends StatelessWidget {
  const PersonalizationPrivacyScreen({super.key});

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
                'Notifications & Privacy',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Customize your experience and privacy preferences.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: TextColor.lightBlack),
            ),
            const SizedBox(height: 30),

            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: BorderColor.paleBrown),
                color: BackgroundColor.offWhite,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notification_important_outlined,
                    size: 30,
                    color: IconColor.brown,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                          'Outfit reminders',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Get gentle nudges to plan outfits in advance.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  CupertinoSwitch(value: false, onChanged: (val) {}),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: BorderColor.paleBrown),
                color: BackgroundColor.offWhite,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.notification_important_outlined,
                    size: 30,
                    color: IconColor.brown,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text(
                          'Packing tips before trips',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Smart suggestions for travel-ready outfits.',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  CupertinoSwitch(value: false, onChanged: (val) {}),
                ],
              ),
            ),

            const SizedBox(height: 50),
            PrimaryButton(
              width: double.maxFinite,
              text: 'Complete Setup',
              onPressed: () {
                Get.toNamed(AppRoutes.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}

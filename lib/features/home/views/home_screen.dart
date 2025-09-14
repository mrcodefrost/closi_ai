import 'package:ai_closet_flutter/core/constants/app_images.dart';
import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/elevated_square_button.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/features/common/buttons/selectable_chips_list.dart';
import 'package:ai_closet_flutter/features/common/custom_text_form_field.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Closi'),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontWeight: FontWeight.w700,
          color: TextColor.camelBrown,
        ),
        leadingWidth: 55,
        leading: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Material(
            color: IconColor.brown, // background
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(), // ripple shape
              onTap: () {
                Get.toNamed(AppRoutes.profile);
              },
              child: Icon(Icons.person, size: 23, color: IconColor.white),
            ),
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              return _showMenuBottomSheet(context);
            },
            icon: Icon(Icons.menu, size: 25, color: IconColor.brown),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableChipsList(
                items: [
                  'Item 1',
                  'Item 2',
                  'Item 3',
                  'Item 4',
                  'Item 5',
                  'Item 6',
                ],
                labelBuilder: (item) => item,
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        AppImages.onboardingOne,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Text(
                          'Effortless Professional',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Weather appropriate blazer for the humidity',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Classic pieces that never go out of style',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 15),
                        SelectableChipsList(
                          items: [
                            'Item 1',
                            'Item 2',
                            'Item 3',
                            'Item 4',
                            'Item 5',
                            'Item 6',
                          ],
                          labelBuilder: (item) => item,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(
                'Ask AI',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(hintText: 'Describe your vibe'),
                  ),
                  const SizedBox(width: 10),
                  PrimaryButton(text: 'Ask', onPressed: () {}),
                ],
              ),
              const SizedBox(height: 10),
              SelectableChipsList(
                items: ['Work', 'Rain', 'Travel'],
                labelBuilder: (item) => item,
              ),
              const SizedBox(height: 20),
              Text(
                'Quick Actions',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Row(
                spacing: 10,
                children: [
                  ElevatedSquareButton(
                    icon: Icons.add,
                    text: 'Add \n Item',
                    onPressed: () {
                      Get.toNamed(AppRoutes.addItem);
                    },
                  ),
                  ElevatedSquareButton(
                    icon: Icons.add,
                    text: 'Open Closet',
                    onPressed: () {
                      Get.toNamed(AppRoutes.closet);
                    },
                  ),
                  ElevatedSquareButton(
                    icon: Icons.add,
                    text: 'Open Trial Room',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'For You',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 240,
                child: ListView.separated(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              height: 170,
                              width: 160,
                              AppImages.onboardingOne,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Casual Friday',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            '3 pieces from your closet',
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: TextColor.lightBlack),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'From your closet',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 240,
                child: ListView.separated(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              height: 170,
                              width: 160,
                              AppImages.onboardingOne,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Classic White Tee',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showMenuBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: BackgroundColor.cream,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            ElevatedSquareButton(
              icon: Icons.calendar_month,
              text: 'Calendar',
              onPressed: () {
                Get.toNamed(AppRoutes.calendar);
              },
            ),
            ElevatedSquareButton(
              icon: Icons.multiline_chart,
              text: 'Analytics',
              onPressed: () {
                Get.toNamed(AppRoutes.analytics);
              },
            ),
            ElevatedSquareButton(
              icon: Icons.shuffle,
              text: 'Mixer',
              onPressed: () {
                Get.toNamed(AppRoutes.mixer);
              },
            ),
            ElevatedSquareButton(
              icon: Icons.psychology,
              text: 'Stylist',
              onPressed: () {
                Get.toNamed(AppRoutes.stylist);
              },
            ),
            ElevatedSquareButton(
              icon: Icons.checkroom,
              text: 'Trial Room',
              onPressed: () {
                Get.toNamed(AppRoutes.trialRoom);
              },
            ),
            ElevatedSquareButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () {
                Get.toNamed(AppRoutes.profile);
              },
            ),
          ],
        ),
      );
    },
  );
}

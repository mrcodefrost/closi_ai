import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/features/common/custom_text_form_field.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: IconColor.brown,
                ),
                child: Text(
                  'C',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text('Closi', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 5),
              Text(
                'Your personal digital wardrobe',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: TextColor.lightBlack),
              ),
              const SizedBox(height: 40),

              CustomTextFormField(
                hintText: 'Email',
                prefixIcon: Icon(Icons.mail, color: IconColor.lightBlack),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hintText: 'Password',
                prefixIcon: Icon(Icons.password, color: IconColor.lightBlack),
                suffixIcon: Icon(Icons.visibility, color: IconColor.lightBlack),
              ),
              const SizedBox(height: 30),

              PrimaryButton(
                width: double.maxFinite,
                text: 'Sign In',
                onPressed: () {
                  Get.toNamed(AppRoutes.home);
                },
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Expanded(
                    child: Divider(color: DividerColor.brown, thickness: 0.5),
                  ),
                  Text('or', style: Theme.of(context).textTheme.bodyMedium),
                  Expanded(
                    child: Divider(color: DividerColor.brown, thickness: 0.5),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                width: double.maxFinite,
                text: 'Continue with Google',
                onPressed: () {
                  Get.toNamed(AppRoutes.home);
                },
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                width: double.maxFinite,
                text: 'Continue with Apple',
                onPressed: () {
                  Get.toNamed(AppRoutes.home);
                },
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Don\'t have an account? Sign Up here.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

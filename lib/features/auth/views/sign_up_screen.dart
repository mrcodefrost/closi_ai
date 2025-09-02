import 'package:ai_closet_flutter/features/common/buttons/primary_button.dart';
import 'package:ai_closet_flutter/features/home/views/welcome_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/color_constants.dart';
import '../../common/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Text(
                'Create account',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 40),
              CustomTextFormField(hintText: 'Name'),
              const SizedBox(height: 20),
              CustomTextFormField(hintText: 'Email'),
              const SizedBox(height: 20),
              CustomTextFormField(hintText: 'Password'),
              const SizedBox(height: 30),
              Text(
                'By creating an account, you agree to our Terms and Privacy Policy.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                width: double.maxFinite,
                text: 'Create Account',
                onPressed: () {
                  Get.to(WelcomeHome());
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
                onPressed: () {},
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                width: double.maxFinite,
                text: 'Continue with Apple',
                onPressed: () {},
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

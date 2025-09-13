import 'package:ai_closet_flutter/features/auth/views/sign_in_screen.dart';
import 'package:ai_closet_flutter/features/auth/views/sign_up_screen.dart';
import 'package:ai_closet_flutter/features/home/views/home_screen.dart';
import 'package:ai_closet_flutter/features/onboarding/views/onboarding_screen.dart';
import 'package:ai_closet_flutter/features/onboarding/views/splash_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_climate_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_gender_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_name_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_privacy_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_sizes_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_style_screen.dart';
import 'package:ai_closet_flutter/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.signUp, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.signIn, page: () => SignInScreen()),
    GetPage(
      name: AppRoutes.personalizationName,
      page: () => PersonalizationNameScreen(),
    ),
    GetPage(
      name: AppRoutes.personalizationGender,
      page: () => PersonalizationGenderScreen(),
    ),
    GetPage(
      name: AppRoutes.personalizationSizes,
      page: () => PersonalizationSizesScreen(),
    ),
    GetPage(
      name: AppRoutes.personalizationStyle,
      page: () => PersonalizationStyleScreen(),
    ),
    GetPage(
      name: AppRoutes.personalizationClimate,
      page: () => PersonalizationClimateScreen(),
    ),
    GetPage(
      name: AppRoutes.personalizationPrivacy,
      page: () => PersonalizationPrivacyScreen(),
    ),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
  ];
}

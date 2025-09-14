import 'package:ai_closet_flutter/features/add_item/views/add_item_screen.dart';
import 'package:ai_closet_flutter/features/add_item/views/batch_tagging_screen.dart';
import 'package:ai_closet_flutter/features/add_item/views/manual_entry_screen.dart';
import 'package:ai_closet_flutter/features/analytics/views/analytics_screen.dart';
import 'package:ai_closet_flutter/features/auth/views/sign_in_screen.dart';
import 'package:ai_closet_flutter/features/auth/views/sign_up_screen.dart';
import 'package:ai_closet_flutter/features/calendar/views/calendar_screen.dart';
import 'package:ai_closet_flutter/features/closet/views/closet_screen.dart';
import 'package:ai_closet_flutter/features/home/views/home_screen.dart';
import 'package:ai_closet_flutter/features/mixer/views/mixer_screen.dart';
import 'package:ai_closet_flutter/features/onboarding/views/onboarding_screen.dart';
import 'package:ai_closet_flutter/features/onboarding/views/splash_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_climate_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_gender_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_name_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_privacy_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_sizes_screen.dart';
import 'package:ai_closet_flutter/features/personalization/views/personalization_style_screen.dart';
import 'package:ai_closet_flutter/features/profile/views/profile_screen.dart';
import 'package:ai_closet_flutter/features/stylist/views/stylist_screen.dart';
import 'package:ai_closet_flutter/features/trial_room/views/trial_room_screen.dart';
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
    GetPage(name: AppRoutes.addItem, page: () => AddItemScreen()),
    GetPage(name: AppRoutes.manualEntry, page: () => ManualEntryScreen()),
    GetPage(name: AppRoutes.batchTagging, page: () => BatchTaggingScreen()),
    GetPage(name: AppRoutes.closet, page: () => ClosetScreen()),
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.analytics, page: () => AnalyticsScreen()),
    GetPage(name: AppRoutes.calendar, page: () => CalendarScreen()),
    GetPage(name: AppRoutes.mixer, page: () => MixerScreen()),
    GetPage(name: AppRoutes.stylist, page: () => StylistScreen()),
    GetPage(name: AppRoutes.trialRoom, page: () => TrialRoomScreen()),
  ];
}

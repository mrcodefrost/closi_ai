import 'package:get/get.dart';
import '../features/onboarding/splash_screen.dart';
import '../features/onboarding/welcome_screen.dart';
import '../features/onboarding/auth_screen.dart';
import '../features/onboarding/permissions_screen.dart';
import '../features/onboarding/style_picker_screen.dart';
import '../features/onboarding/body_profile_screen.dart';
import '../features/onboarding/full_body_photo_screen.dart';
import '../features/home/home_screen.dart';
import '../features/wardrobe/add_item_screen.dart';
import '../features/wardrobe/tag_review_screen.dart';
import '../features/wardrobe/item_detail_screen.dart';
import '../features/outfits/outfits_screen.dart';
import '../features/outfits/outfit_builder_screen.dart';
import '../features/outfits/outfit_detail_screen.dart';
import '../features/trial/trial_room_screen.dart';
import '../features/trial/trial_hifi_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/profile/settings_screen.dart';
import '../features/planner/planner_screen.dart';
import '../features/search/search_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.ONBOARDING,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: AppRoutes.AUTH,
      page: () => const AuthScreen(),
    ),
    GetPage(
      name: AppRoutes.PERMISSIONS,
      page: () => const PermissionsScreen(),
    ),
    GetPage(
      name: AppRoutes.STYLE_PICKER,
      page: () => const StylePickerScreen(),
    ),
    GetPage(
      name: AppRoutes.BODY_PROFILE,
      page: () => const BodyProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.FULL_BODY_PHOTO,
      page: () => const FullBodyPhotoScreen(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.ADD_ITEM,
      page: () => const AddItemScreen(),
    ),
    GetPage(
      name: AppRoutes.TAG_REVIEW,
      page: () => const TagReviewScreen(),
    ),
    GetPage(
      name: AppRoutes.ITEM_DETAIL,
      page: () => const ItemDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.OUTFITS,
      page: () => const OutfitsScreen(),
    ),
    GetPage(
      name: AppRoutes.OUTFIT_BUILDER,
      page: () => const OutfitBuilderScreen(),
    ),
    GetPage(
      name: AppRoutes.OUTFIT_DETAIL,
      page: () => const OutfitDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.TRIAL_ROOM,
      page: () => const TrialRoomScreen(),
    ),
    GetPage(
      name: AppRoutes.TRIAL_HIFI,
      page: () => const TrialHiFiScreen(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: AppRoutes.PLANNER,
      page: () => const PlannerScreen(),
    ),
    GetPage(
      name: AppRoutes.SEARCH,
      page: () => const SearchScreen(),
    ),
  ];
}
import 'package:ai_closet_flutter/core/constants/app_images.dart';
import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/auth/views/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _onIntroEnd(BuildContext context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(
        context,
      ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
      // bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: BackgroundColor.cream,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: BackgroundColor.cream,

      pages: [
        PageViewModel(
          title: "Welcome to Closi",
          body: "Your AI-powered smart closet in your pocket.",
          image: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ), // adds space around the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // rounded corners
              child: Image.asset(
                AppImages.onboardingOne,
                fit: BoxFit.cover, // keep aspect ratio, cover the box
              ),
            ),
          ),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "Your Digital Wardrobe",
          body:
              "Transform your physical closet into a smart digital wardrobe. Bulk import your clothes with AI-powered auto-cutout and intelligent tagging.",
          image: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ), // adds space around the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // rounded corners
              child: Image.asset(
                AppImages.onboardingOne,
                fit: BoxFit.cover, // keep aspect ratio, cover the box
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "AI-Powered Styling",
          body:
              "Get personalized outfit recommendations from your AI Stylist console. Natural language processing understands your style preferences and occasion needs.",
          image: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ), // adds space around the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // rounded corners
              child: Image.asset(
                AppImages.onboardingOne,
                fit: BoxFit.cover, // keep aspect ratio, cover the box
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Try Before You Decide",
          body:
              "Use our Trial Room to visualize outfits with photo try-on capabilities. Compare different combinations and save your favourites.",
          image: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ), // adds space around the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // rounded corners
              child: Image.asset(
                AppImages.onboardingOne,
                fit: BoxFit.cover, // keep aspect ratio, cover the box
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Smart Outfit Creation",
          body:
              "Create outfits through Swiper Mixer for quick combinations or use our Manual Outfit Builder with drag and drop canvas interface.",
          image: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 20,
            ), // adds space around the image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16), // rounded corners
              child: Image.asset(
                AppImages.onboardingOne,
                fit: BoxFit.cover, // keep aspect ratio, cover the box
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

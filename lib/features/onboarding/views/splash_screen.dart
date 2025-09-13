import 'dart:async';

import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:ai_closet_flutter/features/onboarding/views/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: BackgroundColor.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15), // shadow color
                    blurRadius: 12, // how soft the shadow is
                    spreadRadius: 2, // how wide the shadow spreads
                    offset: const Offset(0, 6), // position of shadow (x, y)
                  ),
                ],
              ),
              child: Text(
                'Closi',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: TextColor.camelBrown,
                ),
              ),
            ),
            Spacer(flex: 2),
            CircularProgressIndicator(color: IconColor.brown),
            const SizedBox(height: 20),
            Text(
              'Syncing your wardrobe data...',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: TextColor.lightBlack),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

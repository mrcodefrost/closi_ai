import 'package:flutter/material.dart';

import '../../../core/theme/color_constants.dart';

class WelcomeHome extends StatelessWidget {
  const WelcomeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Center(
                  child: Icon(
                    Icons.dry_cleaning_rounded,
                    color: IconColor.brown,
                    size: 140,
                  ),
                ),
                Text(
                  'Welcome to Closi',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  'Your intelligent wardrobe assistant.\nLet\'s start by adding your first few items to unlock personalized styling.',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Row(
                  spacing: 15,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: IconColor.lightBrown,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        color: IconColor.brown,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Add your first item'),
                          const SizedBox(height: 10),
                          Text(
                            'Tap the + button to add your first item to your closet.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: IconColor.brown),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  spacing: 15,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: IconColor.lightBrown,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.camera),
                        color: IconColor.brown,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Scan Existing Item'),
                          const SizedBox(height: 10),
                          Text(
                            'Use AI to scan an image of an item to add it to your closet.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward, color: IconColor.brown),
                  ],
                ),
                const SizedBox(height: 50),
                Text(
                  'What can you do?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'Discover the power of AI-driven fashion',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        spacing: 5,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.format_paint, color: IconColor.brown),
                          Text(
                            'AI Styling',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Get personalized outfit suggestions, based on weather, events or your style.',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        spacing: 5,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.person, color: IconColor.brown),
                          Text(
                            'Virtual Try-On',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'See how clothes look on you before wearing them with AR Technology.',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: Column(
                        spacing: 5,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.archive, color: IconColor.brown),
                          Text(
                            'Smart Organization',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Automatically categorize and tag your clothes for easy discovery.',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        spacing: 5,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_month, color: IconColor.brown),
                          Text(
                            'Outfit Planning',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Plan your looks for the week and never run out of inspiration.',
                            style: Theme.of(context).textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

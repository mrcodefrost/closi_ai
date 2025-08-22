import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clerk_flutter/clerk_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/router_provider.dart';
import 'core/services/storage/hive_service.dart';
import 'core/services/ai/openai_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  await HiveService.init();
  
  // Initialize Clerk (replace with your Clerk publishable key)
  await Clerk.initialize(
    publishableKey: const String.fromEnvironment(
      'CLERK_PUBLISHABLE_KEY',
      defaultValue: 'pk_test_YOUR_KEY_HERE',
    ),
  );
  
  // Initialize OpenAI
  OpenAIService.initialize();
  
  runApp(const ProviderScope(child: ClosiApp()));
}

class ClosiApp extends ConsumerWidget {
  const ClosiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: 'Closi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}

import 'package:ai_closet_flutter/core/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Closi',
      theme: lightMode,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}

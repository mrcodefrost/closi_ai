import 'package:ai_closet_flutter/core/services/image_service.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ImageService>(ImageService(), permanent: true);
  }
}

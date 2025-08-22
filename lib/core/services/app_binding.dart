import 'package:get/get.dart';
import '../../data/services/api_service.dart';
import '../../data/services/local_storage_service.dart';
import '../../data/repositories/wardrobe_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize core services
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    Get.lazyPut<LocalStorageService>(() => LocalStorageService(), fenix: true);
    
    // Initialize repositories
    Get.lazyPut<WardrobeRepository>(() => WardrobeRepository(), fenix: true);
  }
}

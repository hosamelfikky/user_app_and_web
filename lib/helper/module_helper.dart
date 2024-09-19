import 'package:get/get.dart';
import 'package:user_app_web/common/models/config_model.dart';
import 'package:user_app_web/common/models/module_model.dart';
import 'package:user_app_web/features/splash/controllers/splash_controller.dart';

class ModuleHelper {
  static ModuleModel? getModule() {
    return Get.find<SplashController>().module;
  }

  static ModuleModel? getCacheModule() {
    return Get.find<SplashController>().cacheModule;
  }

  static Module getModuleConfig(String? moduleType) {
    return Get.find<SplashController>().getModuleConfig(moduleType);
  }
}

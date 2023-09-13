import 'package:get/get.dart';

import 'controller.dart';

class HockeyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HockeyController(),
    );
  }
}

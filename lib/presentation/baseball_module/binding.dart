import 'package:get/get.dart';

import 'controller.dart';

class BaseballBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BaseballController(),
    );
  }
}

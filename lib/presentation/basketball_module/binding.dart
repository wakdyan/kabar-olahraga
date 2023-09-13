import 'package:get/get.dart';

import 'controller.dart';

class BasketballBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => BasketballController(),
    );
  }
}

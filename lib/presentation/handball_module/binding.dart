import 'package:get/get.dart';

import 'controller.dart';

class HandballBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HandballController(),
    );
  }
}

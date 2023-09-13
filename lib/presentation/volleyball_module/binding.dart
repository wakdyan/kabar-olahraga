import 'package:get/get.dart';

import 'controller.dart';

class VolleyballBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => VolleyballController(),
    );
  }
}

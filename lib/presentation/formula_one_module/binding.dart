import 'package:get/get.dart';

import 'controller.dart';

class FormulaOneBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FormulaOneController(),
    );
  }
}

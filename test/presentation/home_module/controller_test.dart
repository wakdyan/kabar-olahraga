import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kabar_olahraga/common/constants.dart';
import 'package:kabar_olahraga/presentation/home_module/controller.dart';

void main() {
  late HomeController controller;

  tearDown(() => Get.delete<HomeController>());

  test('check are variables initialized', () {
    controller = Get.put(HomeController());

    expect(controller.tabController.isBlank, false);
    expect(controller.tabs.length, tabData.length);
    expect(controller.pages.length, tabData.length);
  });
}

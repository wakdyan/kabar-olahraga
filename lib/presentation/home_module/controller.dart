import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/constants.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  final tabs = <Tab>[];
  final pages = <Widget>[];

  @override
  void onInit() {
    for (var tab in tabData) {
      tabs.add(Tab(text: tab['label']));
      pages.add(tab['page']);
    }

    tabController = TabController(length: tabs.length, vsync: this);

    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

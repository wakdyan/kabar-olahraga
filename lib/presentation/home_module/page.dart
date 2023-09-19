import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('home_page'),
      appBar: AppBar(
        title: const Text('Kabar Olahraga'),
        bottom: TabBar(
          isScrollable: true,
          controller: controller.tabController,
          tabs: controller.tabs,
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: controller.pages,
      ),
    );
  }
}

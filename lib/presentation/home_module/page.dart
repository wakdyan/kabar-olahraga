import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/enum.dart';
import '../../widgets/error_widget.dart' as w;
import '../../widgets/loader_widget.dart';
import 'controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          if (controller.requestState == RequestState.busy) {
            return const LoaderWidget();
          } else if (controller.requestState == RequestState.error) {
            return w.ErrorWidget(message: controller.errorMessage);
          } else if (controller.requestState == RequestState.success) {
            return _buildLeagues();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildLeagues() {
    return ListView.builder(
      key: const Key('list'),
      itemCount: controller.leagues.length,
      itemBuilder: (_, index) {
        return Text(controller.leagues[index].name);
      },
    );
  }
}

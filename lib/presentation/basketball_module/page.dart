import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/error_widget.dart' as w;
import 'controller.dart';

class BasketballPage extends GetView<BasketballController> {
  const BasketballPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: w.ErrorWidget(message: 'Comming soon'),
    );
  }
}

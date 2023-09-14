import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kabar_olahraga/common/constants.dart';
import 'package:kabar_olahraga/common/enum.dart';
import 'package:kabar_olahraga/presentation/football_module/module.dart';
import 'package:kabar_olahraga/presentation/home_module/module.dart';
import '../../presentation/football_module/page_test.dart' as p;
import 'package:mocktail/mocktail.dart';

import '../../helpers/widget_wrapper.dart';

class Mocking extends GetxController
    with Mock, GetTickerProviderStateMixin
    implements HomeController {
  @override
  TabController get tabController {
    return TabController(length: tabData.length, vsync: this);
  }
}

void main() {
  HomeController controller = Mocking();
  FootballController footballController = p.Mocking();

  tearDownAll(() => Get.reset());

  testWidgets(
    'show football page',
    (tester) async {
      when(() => controller.tabs)
          .thenReturn([for (var tab in tabData) Tab(text: tab['label'])]);
      when(() => controller.pages)
          .thenReturn([for (var tab in tabData) tab['page']]);
      when(() => footballController.requestState)
          .thenReturn(RequestState.success);
      when(() => footballController.countries).thenReturn([]);
      when(() => footballController.getCountries()).thenAnswer((_) async => {});

      Get.put(controller);
      Get.put(footballController);

      await tester.pumpWidget(widgetWrapper(const HomePage()));

      final footbalPage = find.byKey(const Key('home_page'));

      expect(footbalPage, findsOneWidget);
    },
  );
}

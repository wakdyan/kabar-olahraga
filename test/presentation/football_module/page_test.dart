import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kabar_olahraga/common/enum.dart';
import 'package:kabar_olahraga/presentation/football_module/module.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_class.dart';
import '../../helpers/widget_wrapper.dart';

void main() {
  FootballController controller = MockFootballController();

  tearDownAll(() => Get.reset());

  testWidgets(
    'show [loading widget] if state is busy',
    (tester) async {
      when(() => controller.getCountries()).thenAnswer((_) async {});
      when(() => controller.requestState).thenReturn(RequestState.busy);
      when(() => controller.countries).thenReturn([]);

      Get.put(controller);

      await tester.pumpWidget(widgetWrapper(const FootballPage()));

      final loadingWidget = find.byKey(const Key('loader'));

      expect(loadingWidget, findsOneWidget);
    },
  );

  testWidgets(
    'show [error widget] if state is error',
    (tester) async {
      when(() => controller.getCountries()).thenAnswer((_) async {});
      when(() => controller.countries).thenReturn([]);
      when(() => controller.requestState).thenReturn(RequestState.error);
      when(() => controller.errorMessage).thenReturn('failed');

      Get.put(controller);

      await tester.pumpWidget(widgetWrapper(const FootballPage()));

      final errorWidget = find.byKey(const Key('error'));
      final errorMessage = find.text('failed');

      expect(errorWidget, findsOneWidget);
      expect(errorMessage, findsOneWidget);
    },
  );

  testWidgets(
    'show [list widget] if state is success',
    (tester) async {
      when(() => controller.getCountries()).thenAnswer((_) async {});
      when(() => controller.requestState).thenReturn(RequestState.success);
      when(() => controller.countries).thenReturn([]);

      Get.put(controller);

      await tester.pumpWidget(widgetWrapper(const FootballPage()));

      final listWidget = find.byKey(const PageStorageKey('football_list'));

      expect(listWidget, findsOneWidget);
    },
  );
}

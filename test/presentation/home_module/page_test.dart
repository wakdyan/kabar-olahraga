import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kabar_olahraga/common/enum.dart';
import 'package:kabar_olahraga/presentation/home_module/module.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/widget_wrapper.dart';

class Mocking extends GetxController with Mock implements HomeController {}

void main() {
  HomeController controller = Mocking();

  tearDownAll(() => Get.reset());

  testWidgets(
    'show [loading widget] if state is busy',
    (tester) async {
      when(() => controller.requestState).thenReturn(RequestState.idle);

      Get.put(controller);

      await tester.pumpWidget(widgetWrapper(const HomePage()));

      final loadingWidget = find.byKey(const Key('loader'));

      expect(loadingWidget, findsNothing);
    },
  );

  testWidgets(
    'show [error widget] if state is error',
    (tester) async {
      when(() => controller.requestState).thenReturn(RequestState.error);
      when(() => controller.errorMessage).thenReturn('failed');

      Get.put(controller);

      await tester.pumpWidget(widgetWrapper(const HomePage()));

      final errorWidget = find.byKey(const Key('error'));
      final errorMessage = find.text('failed');

      expect(errorWidget, findsOneWidget);
      expect(errorMessage, findsOneWidget);
    },
  );

  testWidgets(
    'show [list widget] if state is success',
    (tester) async {
      when(() => controller.requestState).thenReturn(RequestState.success);
      when(() => controller.leagues).thenReturn([]);

      Get.put(controller);

      await tester.pumpWidget(widgetWrapper(const HomePage()));

      final listWidget = find.byKey(const Key('list'));

      expect(listWidget, findsOneWidget);
    },
  );
}

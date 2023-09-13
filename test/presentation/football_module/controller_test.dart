import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kabar_olahraga/common/enum.dart';
import 'package:kabar_olahraga/common/failure.dart';
import 'package:kabar_olahraga/data/models/country_response.dart';
import 'package:kabar_olahraga/domain/entities/country.dart';
import 'package:kabar_olahraga/presentation/football_module/module.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_class.dart';
import '../../json_reader.dart';

void main() {
  final usecase = MockGetCountries();

  late FootballController controller;

  tearDown(() => Get.delete<FootballController>());

  test('should update [countries] when success', () async {
    final matcher = <Country>[];
    final json = jsonDecode(readJson('dummy/countries_200.json'));
    final parsed = CountryResponse.fromJson(json);

    for (var country in parsed.countries) {
      matcher.add(country.toEntity());
    }

    when(() => usecase.execute()).thenAnswer((_) async => Right(matcher));

    controller = Get.put(FootballController(usecase));

    await controller.getCountries();
    await Future.delayed(const Duration(microseconds: 1));

    expect(controller.countries, matcher);
    expect(controller.errorMessage, '');
    expect(controller.requestState, RequestState.success);
  });

  test('should update [errorMessage] when failed', () async {
    const matcher = 'Server failure';

    when(() => usecase.execute()).thenAnswer((_) async {
      return const Left(ServerFailure(matcher));
    });

    controller = Get.put(FootballController(usecase));

    await controller.getCountries();
    await Future.delayed(const Duration(microseconds: 1));

    expect(controller.countries, []);
    expect(controller.errorMessage, matcher);
    expect(controller.requestState, RequestState.error);
  });
}

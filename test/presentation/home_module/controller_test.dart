import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kabar_olahraga/common/enum.dart';
import 'package:kabar_olahraga/common/failure.dart';
import 'package:kabar_olahraga/data/models/league_response.dart';
import 'package:kabar_olahraga/domain/entities/league.dart';
import 'package:kabar_olahraga/presentation/home_module/controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_class.dart';
import '../../json_reader.dart';

void main() {
  final usecase = MockGetLeagues();

  late HomeController controller;

  tearDown(() => Get.delete<HomeController>());

  test('should update [leagues] when success', () async {
    final matcher = <League>[];
    final json = jsonDecode(readJson('dummy/leagues_200.json'));
    final parsed = LeagueResponse.fromJson(json);

    for (var league in parsed.leagues) {
      matcher.add(league.toEntity());
    }

    when(() => usecase.execute()).thenAnswer((_) async => Right(matcher));

    controller = Get.put(HomeController(usecase));

    await Future.delayed(const Duration(microseconds: 1));

    expect(controller.leagues, matcher);
    expect(controller.errorMessage, '');
    expect(controller.requestState, RequestState.success);
  });

  test('should update [errorMessage] when failed', () async {
    const matcher = 'Server failure';

    when(() => usecase.execute()).thenAnswer((_) async {
      return const Left(ServerFailure(matcher));
    });

    controller = Get.put(HomeController(usecase));

    await Future.delayed(const Duration(microseconds: 1));

    expect(controller.leagues, []);
    expect(controller.errorMessage, matcher);
    expect(controller.requestState, RequestState.error);
  });
}

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/common/failure.dart';
import 'package:kabar_olahraga/data/models/standing_model.dart';
import 'package:kabar_olahraga/data/models/standing_response.dart';
import 'package:kabar_olahraga/domain/usecase/get_standings.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_class.dart';
import '../../json_reader.dart';

void main() {
  const leagueId = 39;
  const season = 2019;

  final mockRepository = MockFootballRepository();
  final usecase = GetStandings(mockRepository);

  test(
    'should return [data] when request is successful',
    () async {
      final json = jsonDecode(readJson('dummy/standings_200.json'));
      final parsed = StandingResponse.fromJson(json);
      final standings = <StandingModel>[];

      for (var standing in parsed.standings) {
        standings.add(standing);
      }

      final matcher = standings[0].toEntity();

      when(() => mockRepository.getStandings(leagueId, season))
          .thenAnswer((_) async => Right(matcher));

      final result = await usecase.execute(leagueId, season);

      expect(result, Right(matcher));
    },
  );

  test(
    'should return [failure] when request is unsuccessful',
    () async {
      when(() => mockRepository.getStandings(leagueId, season))
          .thenAnswer((_) async => const Left(ServerFailure('')));

      final result = await usecase.execute(leagueId, season);

      expect(result, const Left(ServerFailure('')));
    },
  );
}

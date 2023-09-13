import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/common/failure.dart';
import 'package:kabar_olahraga/data/models/standing_response.dart';
import 'package:kabar_olahraga/domain/entities/standing.dart' as e;
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
      final matcher = <e.Standing>[];
      final json = jsonDecode(readJson('dummy/standings_200.json'));
      final parsed = StandingResponse.fromJson(json);

      for (var standing in parsed.standings) {
        matcher.add(standing.toEntity());
      }

      when(() => mockRepository.getStandings(leagueId, season))
          .thenAnswer((_) async => Right(matcher));

      final result = await usecase.execute(leagueId, season);
      final resultList = result.getOrElse(() => []);

      expect(resultList, matcher);
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

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/common/failure.dart';
import 'package:kabar_olahraga/data/models/league_response.dart';
import 'package:kabar_olahraga/domain/entities/league.dart';
import 'package:kabar_olahraga/domain/usecase/get_leagues.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_class.dart';
import '../../json_reader.dart';

void main() {
  final mockRepository = MockFootballRepository();
  final getLeagues = GetLeagues(mockRepository);

  test(
    'should return [data] when request is successful',
    () async {
      final matcher = <League>[];
      final json = jsonDecode(readJson('dummy/leagues_200.json'));
      final parsed = LeagueResponse.fromJson(json);

      for (var league in parsed.leagues) {
        matcher.add(league.toEntity());
      }

      when(() => mockRepository.getLeagues()).thenAnswer((_) async {
        return Right(matcher);
      });

      final result = await getLeagues.execute();
      final resultList = result.getOrElse(() => []);

      expect(resultList, matcher);
    },
  );

  test(
    'should return [failure] when request is unsuccessful',
    () async {
      when(() => mockRepository.getLeagues()).thenAnswer((_) async {
        return const Left(ServerFailure(''));
      });

      final result = await getLeagues.execute();

      expect(result, const Left(ServerFailure('')));
    },
  );
}

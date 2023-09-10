import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/common/failure.dart';
import 'package:kabar_olahraga/data/models/country_response.dart';
import 'package:kabar_olahraga/domain/entities/country.dart';
import 'package:kabar_olahraga/domain/repositories/footbal_repository.dart';
import 'package:kabar_olahraga/domain/usecase/get_countries.dart';
import 'package:mocktail/mocktail.dart';

import '../../json_reader.dart';

class MockFootballRepository extends Mock implements FootballRepository {}

void main() {
  final mockRepository = MockFootballRepository();
  final getCountries = GetCountries(mockRepository);

  test(
    'should return [data] when request is successful',
    () async {
      final matcher = <Country>[];
      final json = jsonDecode(readJson('dummy/countries_200.json'));
      final parsed = CountryResponse.fromJson(json);

      for (var country in parsed.countries) {
        matcher.add(country.toEntity());
      }

      when(() => mockRepository.getCountries()).thenAnswer((_) async {
        return Right(matcher);
      });

      final result = await getCountries.execute();
      final resultList = result.getOrElse(() => []);

      expect(resultList, matcher);
    },
  );

  test(
    'should return [failure] when request is unsuccessful',
    () async {
      when(() => mockRepository.getCountries()).thenAnswer((_) async {
        return const Left(ServerFailure(''));
      });

      final result = await getCountries.execute();

      expect(result, const Left(ServerFailure('')));
    },
  );
}

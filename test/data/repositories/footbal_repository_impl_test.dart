import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/common/exceptions.dart';
import 'package:kabar_olahraga/common/failure.dart';
import 'package:kabar_olahraga/data/models/country_response.dart';
import 'package:kabar_olahraga/data/repositories/footbal_repository_impl.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/mock_class.mocks.dart';
import '../../json_reader.dart';

void main() {
  final mockRemoteDataSource = MockRemoteDataSource();
  final repository = FootballRepositoryImpl(mockRemoteDataSource);

  group('get countries', () {
    test('should return Country when request is successfull', () async {
      final decode = jsonDecode(readJson('dummy/countries_200.json'));
      final countryModel = CountryResponse.fromJson(decode).countries;
      final countries = [
        for (final country in countryModel) country.toEntity()
      ];

      when(mockRemoteDataSource.getCountries()).thenAnswer((_) async {
        return countryModel;
      });

      final result = await repository.getCountries();
      final resultList = result.getOrElse(() => []);

      expect(resultList, countries);
    });

    test('should return ServerFailure when request is unsuccessfull', () async {
      when(mockRemoteDataSource.getCountries())
          .thenThrow(const ServerException(''));

      final result = await repository.getCountries();

      expect(result, const Left(ServerFailure('')));
    });

    test(
      'should return ConnectionFailure when no internet connection',
      () async {
        when(mockRemoteDataSource.getCountries())
            .thenThrow(const SocketException(''));

        final result = await repository.getCountries();

        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });
}

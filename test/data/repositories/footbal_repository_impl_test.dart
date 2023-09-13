import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/common/exceptions.dart';
import 'package:kabar_olahraga/common/failure.dart';
import 'package:kabar_olahraga/data/data_sources/remote_data_source.dart';
import 'package:kabar_olahraga/data/models/country_response.dart';
import 'package:kabar_olahraga/domain/entities/league.dart' as e;
import 'package:kabar_olahraga/data/models/league_response.dart';
import 'package:kabar_olahraga/data/repositories/footbal_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../json_reader.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

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

      when(() => mockRemoteDataSource.getCountries()).thenAnswer((_) async {
        return countryModel;
      });

      final result = await repository.getCountries();
      final resultList = result.getOrElse(() => []);

      expect(resultList, countries);
    });

    test('should return ServerFailure when request is unsuccessfull', () async {
      when(() => mockRemoteDataSource.getCountries())
          .thenThrow(const ServerException(''));

      final result = await repository.getCountries();

      expect(result, const Left(ServerFailure('')));
    });

    test(
      'should return ConnectionFailure when no internet connection',
      () async {
        when(() => mockRemoteDataSource.getCountries())
            .thenThrow(const SocketException(''));

        final result = await repository.getCountries();

        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });

  group('getLeagues', () {
    const countryId = '39';

    test('should return Leauge when request is successfull', () async {
      final decode = json.decode(readJson('dummy/leagues_200.json'));
      final leagueModel = LeagueResponse.fromJson(decode).leagues;
      final leagues = <e.League>[
        for (var league in leagueModel) league.toEntity()
      ];

      when(() => mockRemoteDataSource.getLeagues(countryId))
          .thenAnswer((_) async => leagueModel);

      final result = await repository.getLeagues(countryId);
      final resultList = result.getOrElse(() => []);

      expect(resultList, leagues);
    });

    test(
      'should return ServerFailure when request is unsuccessfull',
      () async {
        when(() => mockRemoteDataSource.getLeagues(countryId))
            .thenThrow(const ServerException(''));

        final result = await repository.getLeagues(countryId);

        expect(result, const Left(ServerFailure('')));
      },
    );

    test(
      'should return ConnectionFailure when no internet connection',
      () async {
        when(() => mockRemoteDataSource.getLeagues(countryId)).thenThrow(
            const SocketException('Failed to connect to the network'));

        final result = await repository.getLeagues(countryId);

        expect(
          result,
          const Left(ConnectionFailure('Failed to connect to the network')),
        );
      },
    );
  });
}

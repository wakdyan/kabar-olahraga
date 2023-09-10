import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kabar_olahraga/common/exceptions.dart';
import 'package:kabar_olahraga/data/data_sources/remote_data_source.dart';
import 'package:kabar_olahraga/data/models/country_response.dart';
import 'package:kabar_olahraga/data/models/fixture_response.dart';
import 'package:kabar_olahraga/data/models/league_response.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_class.dart';
import '../../json_reader.dart';

void main() {
  const baseUrl = 'https://v3.football.api-sports.io/';
  const headers = {
    'x-rapidapi-host': 'v3.football.api-sports.io',
    'x-rapidapi-key': '5f2da4b3d7988f60b7acc56918d331c6',
  };

  final mockHttpClient = MockClient();
  final remoteDataSource = ImplRemoteDataSource(mockHttpClient);

  group(
    'get countries',
    () {
      const uri = '${baseUrl}countries';

      test('should return countries when the status code is 200', () async {
        final countries = CountryResponse.fromJson(
          jsonDecode(readJson('dummy/countries_200.json')),
        ).countries;

        when(
          () => mockHttpClient.get(
            Uri.parse(uri),
            headers: headers,
          ),
        ).thenAnswer(
          (_) async {
            return Response(readJson('dummy/countries_200.json'), 200);
          },
        );

        final result = await remoteDataSource.getCountries();

        expect(result, equals(countries));
      });

      test('should return null when the status code is 204', () async {
        when(
          () => mockHttpClient.get(
            Uri.parse(uri),
            headers: headers,
          ),
        ).thenAnswer(
          (_) async {
            return Response(readJson('dummy/countries_204.json'), 204);
          },
        );

        final result = await remoteDataSource.getCountries();

        expect(result, []);
      });

      test('should throw a server exception when the status code is 500',
          () async {
        when(
          () => mockHttpClient.get(
            Uri.parse(uri),
            headers: headers,
          ),
        ).thenAnswer(
          (_) async {
            return Response(readJson('dummy/countries_500.json'), 500);
          },
        );

        final result = remoteDataSource.getCountries();

        expect(() => result, throwsA(isA<ServerException>()));
      });

      test(
        'throw socket exception when the device is not connected',
        () async {
          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenThrow(const SocketException('message'));

          final result = remoteDataSource.getCountries();

          expect(result, throwsA(isA<SocketException>()));
        },
      );
    },
  );

  group(
    'get leagues',
    () {
      const uri = '${baseUrl}leagues';

      test(
        'should return leagues when the status code is 200',
        () async {
          final leagues = LeagueResponse.fromJson(
            jsonDecode(readJson('dummy/leagues_200.json')),
          ).leagues;

          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/leagues_200.json'), 200);
            },
          );

          final result = await remoteDataSource.getLeagues();

          expect(result, equals(leagues));
        },
      );

      test(
        'should return null when the status code is 204',
        () async {
          final leagues = LeagueResponse.fromJson(
            jsonDecode(readJson('dummy/leagues_204.json')),
          ).leagues;

          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/leagues_204.json'), 200);
            },
          );

          final result = await remoteDataSource.getLeagues();

          expect(result, equals(leagues));
        },
      );

      test(
        'should throw a server exception when the status code is 500',
        () {
          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/leagues_500.json'), 500);
            },
          );

          final result = remoteDataSource.getLeagues();

          expect(result, throwsA(isA<ServerException>()));
        },
      );

      test(
        'throw socket exception when the device is not connected',
        () async {
          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenThrow(const SocketException('message'));

          final result = remoteDataSource.getLeagues();

          expect(result, throwsA(isA<SocketException>()));
        },
      );
    },
  );

  group(
    'get fixtures',
    () {
      const uri = '${baseUrl}fixtures';

      test(
        'should return fixtures when the status code is 200',
        () async {
          final fixtures = FixtureResponse.fromJson(
            jsonDecode(readJson('dummy/fixtures_200.json')),
          ).fixtures;

          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/fixtures_200.json'), 200);
            },
          );

          final result = await remoteDataSource.getFixtures();

          expect(result, fixtures);
        },
      );

      test(
        'should return null when the status code is 204',
        () async {
          final fixtures = FixtureResponse.fromJson(
            jsonDecode(readJson('dummy/fixtures_204.json')),
          ).fixtures;

          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/fixtures_204.json'), 204);
            },
          );

          final result = await remoteDataSource.getFixtures();

          expect(result, fixtures);
        },
      );

      test(
        'should throw a server exception when the status code is 500',
        () async {
          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/fixtures_500.json'), 500);
            },
          );

          final result = remoteDataSource.getFixtures();

          expect(result, throwsA(isA<ServerException>()));
        },
      );

      test(
        'throw socket exception when the device is not connected',
        () async {
          when(
            () => mockHttpClient.get(
              Uri.parse(uri),
              headers: headers,
            ),
          ).thenThrow(const SocketException('message'));

          final result = remoteDataSource.getFixtures();

          expect(result, throwsA(isA<SocketException>()));
        },
      );
    },
  );
}

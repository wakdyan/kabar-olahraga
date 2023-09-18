import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kabar_olahraga/common/exceptions.dart';
import 'package:kabar_olahraga/data/data_sources/remote_data_source.dart';
import 'package:kabar_olahraga/data/models/country_response.dart';
import 'package:kabar_olahraga/data/models/fixture_response.dart';
import 'package:kabar_olahraga/data/models/league_response.dart';
import 'package:kabar_olahraga/data/models/standing_response.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_class.dart';
import '../../json_reader.dart';

void main() {
  const host = 'v3.football.api-sports.io';
  const headers = {
    'x-rapidapi-host': host,
    'x-rapidapi-key': '5f2da4b3d7988f60b7acc56918d331c6',
  };

  final mockHttpClient = MockClient();
  final remoteDataSource = ImplRemoteDataSource(mockHttpClient);

  group(
    'get countries',
    () {
      final uri = Uri(
        scheme: 'https',
        host: host,
        path: 'countries',
      );

      test(
        'should return [countries] when the status code is 200',
        () async {
          final countries = CountryResponse.fromJson(
            jsonDecode(readJson('dummy/countries_200.json')),
          ).countries;

          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/countries_200.json'), 200);
            },
          );

          final result = await remoteDataSource.getCountries();

          expect(result, equals(countries));
        },
      );

      test(
        'should return [null] when the status code is 204',
        () async {
          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/countries_204.json'), 204);
            },
          );

          final result = await remoteDataSource.getCountries();

          expect(result, []);
        },
      );

      test(
        'should throw an [server exception] when the status code is 500',
        () async {
          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/countries_500.json'), 500);
            },
          );

          final result = remoteDataSource.getCountries();

          expect(result, throwsA(isA<ServerException>()));
        },
      );

      test(
        'should throw a [socket exception] when the device is not connected',
        () async {
          when(
            () => mockHttpClient.get(
              uri,
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
      const countryId = '39';
      final uri = Uri(
        scheme: 'https',
        host: host,
        path: 'leagues',
        queryParameters: {'code': countryId},
      );

      test(
        'should return [leagues] when the status code is 200',
        () async {
          final leagues = LeagueResponse.fromJson(
            jsonDecode(readJson('dummy/leagues_200.json')),
          ).leagues;

          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/leagues_200.json'), 200);
            },
          );

          final result = await remoteDataSource.getLeagues(countryId);

          expect(result, equals(leagues));
        },
      );

      test(
        'should return [null] when the status code is 204',
        () async {
          final leagues = LeagueResponse.fromJson(
            jsonDecode(readJson('dummy/leagues_204.json')),
          ).leagues;

          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/leagues_204.json'), 200);
            },
          );

          final result = await remoteDataSource.getLeagues(countryId);

          expect(result, equals(leagues));
        },
      );

      test(
        'should throw a [server exception] when the status code is 500',
        () {
          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer(
            (_) async {
              return Response(readJson('dummy/leagues_500.json'), 500);
            },
          );

          final result = remoteDataSource.getLeagues(countryId);

          expect(result, throwsA(isA<ServerException>()));
        },
      );

      test(
        'throw [socket exception] when the device is not connected',
        () async {
          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenThrow(const SocketException('message'));

          final result = remoteDataSource.getLeagues(countryId);

          expect(result, throwsA(isA<SocketException>()));
        },
      );
    },
  );

  group(
    'get fixtures',
    () {
      final uri = Uri(
        scheme: 'https',
        host: host,
        path: 'fixtures',
      );

      test(
        'should return [fixtures] when the status code is 200',
        () async {
          final fixtures = FixtureResponse.fromJson(
            jsonDecode(readJson('dummy/fixtures_200.json')),
          ).fixtures;

          when(
            () => mockHttpClient.get(
              uri,
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
        'should return [null] when the status code is 204',
        () async {
          final fixtures = FixtureResponse.fromJson(
            jsonDecode(readJson('dummy/fixtures_204.json')),
          ).fixtures;

          when(
            () => mockHttpClient.get(
              uri,
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
        'should throw a [server exception] when the status code is 500',
        () async {
          when(
            () => mockHttpClient.get(
              uri,
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
        'should throw [socket exception] when the device is not connected',
        () async {
          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenThrow(const SocketException('message'));

          final result = remoteDataSource.getFixtures();

          expect(result, throwsA(isA<SocketException>()));
        },
      );
    },
  );

  group(
    'get standings',
    () {
      const leagueId = 39;
      const season = 2019;
      final uri = Uri(
        scheme: 'https',
        host: host,
        path: 'standings',
        queryParameters: {
          'league': '$leagueId',
          'season': '$season',
        },
      );

      test(
        'should return [standings] when the status code is 200',
        () async {
          final rawJson = readJson('dummy/standings_200.json');
          final json = jsonDecode(rawJson);
          final matcher = StandingResponse.fromJson(json).standings;

          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer((_) async => Response(rawJson, 200));

          final result = await remoteDataSource.getStandings(leagueId, season);

          expect(result, matcher);
        },
      );

      test(
        'should return [null] when the status code is 204',
        () async {
          final rawJson = readJson('dummy/standings_204.json');
          final json = jsonDecode(rawJson);
          final matcher = StandingResponse.fromJson(json).standings;

          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer((_) async => Response(rawJson, 204));

          final result = await remoteDataSource.getStandings(leagueId, season);

          expect(result, matcher);
        },
      );

      test(
        'should throw [server exception] when the status code is 500',
        () async {
          final rawJson = readJson('dummy/standings_500.json');

          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenAnswer((_) async => Response(rawJson, 500));

          final result = remoteDataSource.getStandings(leagueId, season);

          expect(result, throwsA(isA<ServerException>()));
        },
      );

      test(
        'should throw [socket exception] when the device is not connected',
        () async {
          when(
            () => mockHttpClient.get(
              uri,
              headers: headers,
            ),
          ).thenThrow(const SocketException('message'));

          final result = remoteDataSource.getStandings(leagueId, season);

          expect(result, throwsA(isA<SocketException>()));
        },
      );
    },
  );
}

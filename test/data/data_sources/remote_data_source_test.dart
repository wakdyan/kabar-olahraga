import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/common/exceptions.dart';
import 'package:kabar_olahraga/data/data_sources/remote_data_source.dart';
import 'package:kabar_olahraga/data/models/country_response.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/mock_class.mocks.dart';
import '../../json_reader.dart';

void main() {
  const baseUrl = 'https://v3.football.api-sports.io/';

  final mockHttpClient = MockHttpClient();
  final remoteDataSource = ImplRemoteDataSource(mockHttpClient);

  group(
    'get countries',
    () {
      test('should return countries when the status code is 200', () async {
        final countries = CountryResponse.fromJson(
          jsonDecode(readJson('dummy/countries_200.json')),
        ).countries;

        when(
          mockHttpClient.get(
            Uri.parse('${baseUrl}countries'),
            headers: {
              'x-rapidapi-host': 'v3.football.api-sports.io',
              'x-rapidapi-key': '5f2da4b3d7988f60b7acc56918d331c6',
            },
          ),
        ).thenAnswer(
          (_) async {
            return http.Response(readJson('dummy/countries_200.json'), 200);
          },
        );

        final result = await remoteDataSource.getCountries();

        expect(result, equals(countries));
      });

      test('should return null when the status code is 204', () async {
        when(
          mockHttpClient.get(
            Uri.parse('${baseUrl}countries'),
            headers: {
              'x-rapidapi-host': 'v3.football.api-sports.io',
              'x-rapidapi-key': '5f2da4b3d7988f60b7acc56918d331c6',
            },
          ),
        ).thenAnswer(
          (_) async {
            return http.Response(readJson('dummy/countries_204.json'), 204);
          },
        );

        final result = await remoteDataSource.getCountries();

        expect(result, []);
      });

      test('should throw an time out exception when the status code is 499',
          () async {
        when(
          mockHttpClient.get(
            Uri.parse('${baseUrl}countries'),
            headers: {
              'x-rapidapi-host': 'v3.football.api-sports.io',
              'x-rapidapi-key': '5f2da4b3d7988f60b7acc56918d331c6',
            },
          ),
        ).thenAnswer(
          (_) async {
            return http.Response(readJson('dummy/countries_499.json'), 499);
          },
        );

        final result = remoteDataSource.getCountries();

        expect(() => result, throwsA(isA<TimeOutException>()));
      });

      test('should throw a server exception when the status code is 500',
          () async {
        when(
          mockHttpClient.get(
            Uri.parse('${baseUrl}countries'),
            headers: {
              'x-rapidapi-host': 'v3.football.api-sports.io',
              'x-rapidapi-key': '5f2da4b3d7988f60b7acc56918d331c6',
            },
          ),
        ).thenAnswer(
          (_) async {
            return http.Response(readJson('dummy/countries_500.json'), 500);
          },
        );

        final result = remoteDataSource.getCountries();

        expect(() => result, throwsA(isA<ServerException>()));
      });
    },
  );
}

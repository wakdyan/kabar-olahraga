import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../common/exceptions.dart';
import '../models/country_model.dart';
import '../models/country_response.dart';
import '../models/fixture_model.dart';
import '../models/fixture_response.dart';
import '../models/league_model.dart';
import '../models/league_response.dart';
import '../models/standing_model.dart';
import '../models/standing_response.dart';

abstract class RemoteDataSource {
  Future<List<CountryModel>> getCountries();

  Future<List<LeagueModel>> getLeagues(String countryId);

  Future<List<FixtureModel>> getFixtures();

  Future<List<StandingModel>> getStandings(int leagueId, int season);
}

class ImplRemoteDataSource extends GetxService implements RemoteDataSource {
  final Client _client;

  static const _apiKey = String.fromEnvironment('api_key');
  static const _host = 'v3.football.api-sports.io';
  static const _headers = {
    'x-rapidapi-host': _host,
    'x-rapidapi-key': _apiKey,
  };

  ImplRemoteDataSource(this._client);

  @override
  Future<List<CountryModel>> getCountries() async {
    try {
      final uri = Uri(scheme: 'https', host: _host, path: 'countries');
      final result = await _client.get(uri, headers: _headers);
      final json = jsonDecode(result.body);

      if (result.statusCode == 200 || result.statusCode == 204) {
        return CountryResponse.fromJson(json).countries;
      } else {
        throw ServerException(json['message']);
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<LeagueModel>> getLeagues(String countryId) async {
    try {
      final uri = Uri(
        scheme: 'https',
        host: _host,
        path: 'leagues',
        query: 'code=$countryId',
      );
      final result = await _client.get(uri, headers: _headers);
      final json = jsonDecode(result.body);

      if (result.statusCode == 200 || result.statusCode == 204) {
        return LeagueResponse.fromJson(json).leagues;
      } else {
        throw ServerException(json['message']);
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<FixtureModel>> getFixtures() async {
    try {
      final uri = Uri(scheme: 'https', host: _host, path: 'fixtures');
      final result = await _client.get(uri, headers: _headers);
      final json = jsonDecode(result.body);

      if (result.statusCode == 200 || result.statusCode == 204) {
        return FixtureResponse.fromJson(json).fixtures;
      } else {
        throw ServerException(json['message']);
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<StandingModel>> getStandings(int leagueId, int season) async {
    try {
      final uri = Uri(
        scheme: 'https',
        host: _host,
        path: 'standings',
        queryParameters: {
          'league': '$leagueId',
          'season': '$season',
        },
      );
      final result = await _client.get(uri, headers: _headers);
      final json = jsonDecode(result.body);

      if (result.statusCode == 200 || result.statusCode == 204) {
        return StandingResponse.fromJson(json).standings;
      } else {
        throw ServerException(json['message']);
      }
    } catch (_) {
      rethrow;
    }
  }
}

import 'dart:convert';

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

  Future<StandingModel> getStandings(int leagueId, int season);
}

class ImplRemoteDataSource extends RemoteDataSource {
  final Client _client;

  final _baseUrl = 'https://v3.football.api-sports.io/';
  final _headers = {
    'x-rapidapi-host': 'v3.football.api-sports.io',
    'x-rapidapi-key': '5f2da4b3d7988f60b7acc56918d331c6',
  };

  ImplRemoteDataSource(this._client);

  @override
  Future<List<CountryModel>> getCountries() async {
    try {
      final result = await _client.get(
        Uri.parse('${_baseUrl}countries'),
        headers: _headers,
      );
      final json = jsonDecode(result.body);
      if (result.statusCode == 200 || result.statusCode == 204) {
        return CountryResponse.fromJson(json).countries;
      } else {
        throw ServerException(json['message']);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<LeagueModel>> getLeagues(String countryId) async {
    try {
      final result = await _client.get(
        Uri.parse('${_baseUrl}leagues?code=$countryId'),
        headers: _headers,
      );
      final json = jsonDecode(result.body);
      if (result.statusCode == 200 || result.statusCode == 204) {
        return LeagueResponse.fromJson(json).leagues;
      } else {
        throw ServerException(json['message']);
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FixtureModel>> getFixtures() async {
    final result = await _client.get(
      Uri.parse('${_baseUrl}fixtures'),
      headers: _headers,
    );
    final json = jsonDecode(result.body);
    if (result.statusCode == 200 || result.statusCode == 204) {
      return FixtureResponse.fromJson(json).fixtures;
    } else {
      throw ServerException(json['message']);
    }
  }

  @override
  Future<StandingModel> getStandings(int leagueId, int season) async {
    final result = await _client.get(
      Uri.parse('${_baseUrl}standings'),
      headers: _headers,
    );
    final json = jsonDecode(result.body);
    if (result.statusCode == 200 || result.statusCode == 204) {
      return StandingResponse.fromJson(json).standing;
    } else {
      throw ServerException(json['message']);
    }
  }
}

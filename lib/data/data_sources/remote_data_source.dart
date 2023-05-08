import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kabar_olahraga/data/models/country_response.dart';

import '../../common/exceptions.dart';
import '../models/country_model.dart';

abstract class RemoteDataSource {
  Future<List<CountryModel>> getCountries();
}

class ImplRemoteDataSource extends RemoteDataSource {
  final http.Client _client;

  final baseUrl = 'https://v3.football.api-sports.io/';

  ImplRemoteDataSource(this._client);

  @override
  Future<List<CountryModel>> getCountries() async {
    final result = await _client.get(
      Uri.parse('${baseUrl}countries'),
      headers: {
        'x-rapidapi-host': 'v3.football.api-sports.io',
        'x-rapidapi-key': '5f2da4b3d7988f60b7acc56918d331c6',
      },
    );
    final json = jsonDecode(result.body);
    if (result.statusCode == 200 || result.statusCode == 204) {
      return CountryResponse.fromJson(json).countries;
    } else if (result.statusCode == 499) {
      throw TimeOutException(json['message']);
    } else if (result.statusCode == 500) {
      throw ServerException(json['message']);
    } else {
      throw Exception('Unknown error');
    }
  }
}

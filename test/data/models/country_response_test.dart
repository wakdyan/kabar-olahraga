import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/data/models/country_model.dart';
import 'package:kabar_olahraga/data/models/country_response.dart';

import '../../json_reader.dart';

void main() {
  test('country response parsing with data', () {
    const countries = <CountryModel>[
      CountryModel(
        "England",
        "GB",
        "https://media.api-sports.io/flags/gb.svg",
      ),
    ];
    const matcher = CountryResponse(countries);

    final parsedJson = jsonDecode(readJson('dummy/countries_200.json'));
    final result = CountryResponse.fromJson(parsedJson);

    expect(result, matcher);
  });

  test('country response parsing with empty data', () {
    const countries = <CountryModel>[];
    const matcher = CountryResponse(countries);

    final parsedJson = jsonDecode(readJson('dummy/countries_204.json'));
    final result = parsedJson['response'];

    expect(result, matcher.countries);
  });

  test('country response parsing with error', () {
    const matcher =
        'Something went wrong while fetching details. Try again later.';

    final parsedJson = jsonDecode(readJson('dummy/countries_499.json'));
    final result = parsedJson['message'];

    expect(result, matcher);
  });

  test('country response unparsing', () {
    const matcher = {
      "response": [
        {
          "name": "England",
          "code": "GB",
          "flag": "https://media.api-sports.io/flags/gb.svg"
        },
      ],
    };
    const countries = [
      CountryModel(
        "England",
        "GB",
        "https://media.api-sports.io/flags/gb.svg",
      ),
    ];
    const data = CountryResponse(countries);

    final result = data.toJson();

    expect(result, matcher);
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/data/models/country_model.dart';

import '../../json_reader.dart';

void main() {
  test('country model parsing', () {
    const matcher = CountryModel(
      "England",
      "GB",
      "https://media.api-sports.io/flags/gb.svg",
    );

    final parsedJson = jsonDecode(readJson('dummy/countries_200.json'));
    final responses = parsedJson['response'];
    final result = CountryModel.fromJson(responses[0]);

    expect(result, matcher);
  });
}

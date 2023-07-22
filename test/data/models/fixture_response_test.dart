import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/data/models/fixture_model.dart';
import 'package:kabar_olahraga/data/models/fixture_response.dart';

import '../../json_reader.dart';

void main() {
  test('fixture response parsing with data', () {
    const fixtures = [
      FixtureModel(
        fixture: Fixture(
          id: 239625,
          referee: null,
          timezone: 'UTC',
          date: '2020-02-06T14:00:00+00:00',
          timestamp: 1580997600,
          periods: {
            'first': 1580997600,
            'second': null,
          },
          venue: {"id": 1887, "name": "Stade Municipal", "city": "Oued Zem"},
          status: {"long": "Halftime", "short": "HT", "elapsed": 45},
        ),
        league: League(
          id: 200,
          name: 'Botola Pro',
          country: 'Morocco',
          logo: 'https://media.api-sports.io/football/leagues/115.png',
          flag: 'https://media.api-sports.io/flags/ma.svg',
          season: 2019,
          round: 'Regular Season - 14',
        ),
        teams: Team(
          home: Match(
            id: 967,
            name: 'Rapide Oued ZEM',
            logo: 'https://media.api-sports.io/football/teams/967.png',
            winner: false,
          ),
          away: Match(
            id: 968,
            name: 'Wydad AC',
            logo: 'https://media.api-sports.io/football/teams/968.png',
            winner: true,
          ),
        ),
        goals: Goal(0, 1),
        score: Score(
          halfTime: Goal(0, 1),
          fullTime: Goal(null, null),
          extraTime: Goal(null, null),
          penalty: Goal(null, null),
        ),
      ),
    ];
    const matcher = FixtureResponse(fixtures);

    final parsedJson = jsonDecode(readJson('dummy/fixtures_200.json'));
    final result = FixtureResponse.fromJson(parsedJson);

    expect(matcher, result);
  });

  test('fixture response parsing with empty data', () {
    const fixtures = <FixtureModel>[];
    const matcher = FixtureResponse(fixtures);

    final parsedJson = jsonDecode(readJson('dummy/fixtures_204.json'));
    final result = FixtureResponse.fromJson(parsedJson);

    expect(matcher, result);
  });

  test('fixture response parsing with error', () {
    const matcher =
        'Something went wrong while fetching details. Try again later.';

    final parsedJson = jsonDecode(readJson('dummy/fixtures_499.json'));
    final result = parsedJson['message'];

    expect(matcher, result);
  });
}

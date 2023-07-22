import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/data/models/league_model.dart';

import '../../json_reader.dart';

void main() {
  test('league model parsing test', () {
    const matcher = LeagueModel(
      league: League(
        39,
        'Premier League',
        'League',
        'https://media.api-sports.io/football/leagues/2.png',
      ),
      country: Country(
        'England',
        'GB',
        'https://media.api-sports.io/flags/gb.svg',
      ),
      seasons: [
        Season(
          2010,
          '2010-08-14',
          '2011-05-17',
          false,
          Coverage(
            fixtures: Fixtures(
              events: true,
              lineups: true,
              statisticsFixtures: false,
              statisticsPlayers: false,
            ),
            standings: true,
            players: true,
            topScores: true,
            topAssists: true,
            topCards: true,
            injuries: true,
            predictions: true,
            odds: false,
          ),
        ),
        Season(
          2011,
          '2011-08-13',
          '2012-05-13',
          false,
          Coverage(
            fixtures: Fixtures(
              events: true,
              lineups: true,
              statisticsFixtures: false,
              statisticsPlayers: false,
            ),
            standings: true,
            players: true,
            topScores: true,
            topAssists: true,
            topCards: true,
            injuries: true,
            predictions: true,
            odds: false,
          ),
        ),
      ],
    );

    final parsedJson = jsonDecode(readJson('dummy/leagues_200.json'));
    final responses = parsedJson['response'];
    final result = LeagueModel.fromJson(responses[0]);

    expect(result, matcher);
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kabar_olahraga/data/models/standing_model.dart';
import 'package:kabar_olahraga/data/models/standing_response.dart';

import '../../json_reader.dart';

void main() {
  test('standing response parsing test', () {
    const standing = StandingModel(
      league: League(
        id: 39,
        season: 2019,
        name: 'Premier League',
        country: 'England',
        logo: 'https://media.api-sports.io/football/leagues/2.png',
        flag: 'https://media.api-sports.io/flags/gb.svg',
      ),
      standings: [
        [
          Standing(
            rank: 1,
            team: Team(
              id: 40,
              name: 'Liverpool',
              logo: 'https://media.api-sports.io/football/teams/40.png',
            ),
            points: 70,
            goalsDiff: 41,
            group: 'Premier League',
            form: 'WWWWW',
            status: 'same',
            description: 'Promotion - Champions League (Group Stage)',
            all: Match(
              played: 24,
              win: 23,
              draw: 1,
              lose: 0,
              goals: (56, 15),
            ),
            home: Match(
              played: 12,
              win: 12,
              draw: 0,
              lose: 0,
              goals: (31, 9),
            ),
            away: Match(
              played: 12,
              win: 11,
              draw: 1,
              lose: 0,
              goals: (25, 6),
            ),
          )
        ],
      ],
    );
    const matcher = StandingResponse([standing]);
    final parsedJson = jsonDecode(readJson('dummy/standings_200.json'));
    final result = StandingResponse.fromJson(parsedJson);

    expect(result, matcher);
  });
}

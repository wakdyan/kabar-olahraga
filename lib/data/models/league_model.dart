import 'package:equatable/equatable.dart';
import '../../domain/entities/league.dart' as e;

class LeagueModel extends Equatable {
  final League league;
  final Country country;
  final List<Season> seasons;

  const LeagueModel({
    required this.league,
    required this.country,
    required this.seasons,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      league: League.fromJson(json['league']),
      country: Country.fromJson(json['country']),
      seasons:
          List.from(json['seasons']).map((e) => Season.fromJson(e)).toList(),
    );
  }

  e.League toEntity() {
    return e.League(
      league.id,
      league.name,
      league.type,
      league.logo,
    );
  }

  @override
  List<Object?> get props => [league, country, seasons];
}

class League extends Equatable {
  final int id;
  final String name;
  final String type;
  final String logo;

  const League(this.id, this.name, this.type, this.logo);

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      json['id'],
      json['name'],
      json['type'],
      json['logo'],
    );
  }

  @override
  List<Object?> get props => [id, name, type, logo];
}

class Country extends Equatable {
  final String name;
  final String code;
  final String flag;

  const Country(this.name, this.code, this.flag);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['name'],
      json['code'],
      json['flag'],
    );
  }

  @override
  List<Object?> get props => [name, code, flag];
}

class Season extends Equatable {
  final int year;
  final String start;
  final String end;
  final bool current;
  final Coverage coverage;

  const Season(this.year, this.start, this.end, this.current, this.coverage);

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      json['year'],
      json['start'],
      json['end'],
      json['current'],
      Coverage.fromJson(json['coverage']),
    );
  }

  @override
  List<Object?> get props => [year, start, end, current, coverage];
}

class Coverage extends Equatable {
  final Fixtures fixtures;
  final bool standings;
  final bool players;
  final bool topScores;
  final bool topAssists;
  final bool topCards;
  final bool injuries;
  final bool predictions;
  final bool odds;

  const Coverage({
    required this.fixtures,
    required this.standings,
    required this.players,
    required this.topScores,
    required this.topAssists,
    required this.topCards,
    required this.injuries,
    required this.predictions,
    required this.odds,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) {
    return Coverage(
      fixtures: Fixtures.fromJson(json['fixtures']),
      standings: json['standings'],
      players: json['players'],
      topScores: json['top_scorers'],
      topAssists: json['top_assists'],
      topCards: json['top_cards'],
      injuries: json['injuries'],
      predictions: json['predictions'],
      odds: json['odds'],
    );
  }

  @override
  List<Object?> get props {
    return [
      fixtures,
      standings,
      players,
      topScores,
      topAssists,
      topCards,
      injuries,
      predictions,
      odds,
    ];
  }
}

class Fixtures extends Equatable {
  final bool events;
  final bool lineups;
  final bool statisticsFixtures;
  final bool statisticsPlayers;

  const Fixtures({
    required this.events,
    required this.lineups,
    required this.statisticsFixtures,
    required this.statisticsPlayers,
  });

  factory Fixtures.fromJson(Map<String, dynamic> json) {
    return Fixtures(
      events: json['events'],
      lineups: json['lineups'],
      statisticsFixtures: json['statistics_fixtures'],
      statisticsPlayers: json['statistics_players'],
    );
  }

  @override
  List<Object?> get props {
    return [
      events,
      lineups,
      statisticsFixtures,
      statisticsPlayers,
    ];
  }
}

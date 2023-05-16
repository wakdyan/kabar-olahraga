import 'package:equatable/equatable.dart';

class FixtureModel extends Equatable {
  final Fixture fixture;
  final League league;
  final Team teams;
  final Goal goals;
  final Score score;

  const FixtureModel({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
    required this.score,
  });

  factory FixtureModel.fromJson(Map<String, dynamic> json) {
    return FixtureModel(
        fixture: Fixture.fromJson(json['fixture']),
        league: League.fromJson(json['league']),
        teams: Team.fromJson(json['teams']),
        goals: Goal.fromJson(json['goals']),
        score: Score.fromJson(json['score']));
  }

  @override
  List<Object?> get props => [fixture, league, teams, goals];
}

class Fixture extends Equatable {
  final int id;
  final String? referee;
  final String timezone;
  final String date;
  final int timestamp;
  final Map<String, dynamic> periods;
  final Map<String, dynamic> venue;
  final Map<String, dynamic> status;

  const Fixture({
    required this.id,
    required this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
    required this.periods,
    required this.venue,
    required this.status,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'],
      referee: json['referee'],
      timezone: json['timezone'],
      date: json['date'],
      timestamp: json['timestamp'],
      periods: json['periods'],
      venue: json['venue'],
      status: json['status'],
    );
  }

  @override
  List<Object?> get props {
    return [id, referee, timezone, date, timestamp, periods, venue, status];
  }
}

class League extends Equatable {
  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;
  final String round;

  const League({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.round,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      flag: json['flag'],
      season: json['season'],
      round: json['round'],
    );
  }

  @override
  List<Object?> get props => [id, name, country, logo, flag, season, round];
}

class Team extends Equatable {
  final Match home;
  final Match away;

  const Team({
    required this.home,
    required this.away,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      home: Match.fromJson(json['home']),
      away: Match.fromJson(json['away']),
    );
  }

  @override
  List<Object?> get props => [home, away];
}

class Match extends Equatable {
  final int id;
  final String name;
  final String logo;
  final bool winner;

  const Match({
    required this.id,
    required this.name,
    required this.logo,
    required this.winner,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      winner: json['winner'],
    );
  }

  @override
  List<Object?> get props => [id, name, logo, winner];
}

class Goal extends Equatable {
  final int? home;
  final int? away;

  const Goal(this.home, this.away);

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(json['home'], json['away']);
  }

  @override
  List<Object?> get props => [home, away];
}

class Score extends Equatable {
  final Goal halfTime;
  final Goal fullTime;
  final Goal extraTime;
  final Goal penalty;

  const Score({
    required this.halfTime,
    required this.fullTime,
    required this.extraTime,
    required this.penalty,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      halfTime: Goal.fromJson(json['halftime']),
      fullTime: Goal.fromJson(json['fulltime']),
      extraTime: Goal.fromJson(json['extratime']),
      penalty: Goal.fromJson(json['penalty']),
    );
  }

  @override
  List<Object?> get props => [halfTime, fullTime, extraTime, penalty];
}

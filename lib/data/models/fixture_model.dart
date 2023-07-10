import 'package:equatable/equatable.dart';

part 'fixture_model_fixture.dart';
part 'fixture_model_goal.dart';
part 'fixture_model_league.dart';
part 'fixture_model_match.dart';
part 'fixture_model_score.dart';
part 'fixture_model_team.dart';

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
      score: Score.fromJson(json['score']),
    );
  }

  @override
  List<Object?> get props => [fixture, league, teams, goals];
}

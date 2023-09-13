part of 'standing_model.dart';

class Standing extends Equatable {
  final int rank;
  final Team team;
  final int points;
  final int goalsDiff;
  final String group;
  final String form;
  final String status;
  final String description;
  final Match all;
  final Match home;
  final Match away;

  const Standing({
    required this.rank,
    required this.team,
    required this.points,
    required this.goalsDiff,
    required this.group,
    required this.form,
    required this.status,
    required this.description,
    required this.all,
    required this.home,
    required this.away,
  });

  factory Standing.fromJson(Map<String, dynamic> json) {
    return Standing(
      rank: json['id'],
      team: json['team'],
      points: json['points'],
      goalsDiff: json['goalsDiff'],
      group: json['group'],
      form: json['form'],
      status: json['status'],
      description: json['description'],
      all: Match.fromJson(json['all']),
      home: Match.fromJson(json['home']),
      away: Match.fromJson(json['away']),
    );
  }

  m.Standing toEntity() {
    return m.Standing(
      rank: rank,
      team: (team.id, team.name, team.logo),
      points: points,
      goalsDiff: goalsDiff,
      group: group,
      form: form,
      status: status,
      description: description,
      all: (
        played: all.played,
        goals: all.goals,
        win: all.win,
        draw: all.draw,
        lose: all.lose,
      ),
    );
  }

  @override
  List<Object?> get props {
    return [
      rank,
      team,
      points,
      goalsDiff,
      group,
      form,
      status,
      description,
      all,
      home,
      away,
    ];
  }
}

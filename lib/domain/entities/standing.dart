import 'package:equatable/equatable.dart';

class Standing extends Equatable {
  final int rank;
  final (int id, String name, String logo) team;
  final int points;
  final int goalsDiff;
  final String group;
  final String form;
  final String status;
  final String description;
  final ({
    int played,
    int win,
    int draw,
    int lose,
    (int from, int against) goals,
  }) all;

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
  });
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
    ];
  }
}

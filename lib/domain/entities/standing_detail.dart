import 'package:equatable/equatable.dart';

import 'match_history.dart';
import 'team.dart';

class StandingDetail extends Equatable {
  final int rank, points, goalsDiff;
  final String group, form, status;
  final String? description;
  final Team team;
  final MatchHistory matchHistory;

  const StandingDetail({
    required this.rank,
    required this.points,
    required this.goalsDiff,
    required this.group,
    required this.form,
    required this.status,
    required this.description,
    required this.team,
    required this.matchHistory,
  });

  @override
  List<Object?> get props {
    return [
      rank,
      points,
      goalsDiff,
      group,
      form,
      status,
      description,
      team,
      matchHistory,
    ];
  }
}

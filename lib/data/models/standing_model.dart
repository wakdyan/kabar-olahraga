import 'package:equatable/equatable.dart';

import '../../domain/entities/league.dart' as e;
import '../../domain/entities/match_history.dart' as e;
import '../../domain/entities/standing.dart' as e;
import '../../domain/entities/standing_detail.dart';
import '../../domain/entities/team.dart' as e;

part 'standing_model_league.dart';
part 'standing_model_match.dart';
part 'standing_model_standing.dart';
part 'standing_model_team.dart';

class StandingModel extends Equatable {
  final League league;
  final List<List<Standing>> standings;

  const StandingModel({required this.league, required this.standings});

  factory StandingModel.fromJson(Map<String, dynamic> json) {
    final league = json['league'];
    return StandingModel(
      league: League.fromJson(league),
      standings: List.from(league['standings']).map<List<Standing>>(
        (e) {
          return e.map<Standing>(
            (e) {
              return Standing.fromJson(e);
            },
          ).toList();
        },
      ).toList(),
    );
  }

  e.Standing toEntity() {
    return e.Standing(
      league: league.toEntity(),
      standings: standings[0].map(
        (standings) {
          final data = standings;
          return StandingDetail(
            rank: data.rank,
            points: data.points,
            goalsDiff: data.goalsDiff,
            group: data.group,
            form: data.form,
            status: data.status,
            description: data.description,
            team: data.team.toEntity(),
            matchHistory: data.all.toEntity(),
          );
        },
      ).toList(),
    );
  }

  @override
  List<Object?> get props => [league, standings];
}

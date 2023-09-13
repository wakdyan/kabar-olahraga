import 'package:equatable/equatable.dart';
import '../../domain/entities/standing.dart' as m;
part 'standing_model_league.dart';
part 'standing_model_match.dart';
part 'standing_model_standing.dart';
part 'standing_model_team.dart';

class StandingModel extends Equatable {
  final League league;
  final List<Standing> standings;

  const StandingModel({required this.league, required this.standings});

  factory StandingModel.fromJson(Map<String, dynamic> json) {
    return StandingModel(
      league: json['league'],
      standings: List.from(json['standings'])
          .map((e) => Standing.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [league, standings];
}

import 'package:equatable/equatable.dart';

import '../../domain/entities/league.dart' as e;

part 'league_model_country.dart';
part 'league_model_coverage.dart';
part 'league_model_fixture.dart';
part 'league_model_league.dart';
part 'league_model_season.dart';

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

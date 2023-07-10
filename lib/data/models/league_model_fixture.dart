part of 'league_model.dart';

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

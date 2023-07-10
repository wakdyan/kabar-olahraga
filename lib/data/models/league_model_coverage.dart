part of 'league_model.dart';

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

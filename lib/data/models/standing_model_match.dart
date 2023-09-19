part of 'standing_model.dart';

class Match extends Equatable {
  final int played, win, draw, lose;
  final (int from, int against) goals;

  const Match({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      played: json['played'] ?? 0,
      win: json['win'] ?? 0,
      draw: json['draw'] ?? 0,
      lose: json['lose'] ?? 0,
      goals: (json['goals']['for'] ?? 0, json['goals']['against'] ?? 0),
    );
  }

  @override
  List<Object?> get props => [played, win, draw, lose, goals];

  e.MatchHistory toEntity() {
    return e.MatchHistory(
      played: played,
      win: win,
      draw: draw,
      lose: lose,
      goals: goals,
    );
  }
}

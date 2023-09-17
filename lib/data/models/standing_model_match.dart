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
      played: json['played'],
      win: json['win'],
      draw: json['draw'],
      lose: json['lose'],
      goals: (json['goals']['for'], json['goals']['against']),
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

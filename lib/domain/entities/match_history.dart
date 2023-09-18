import 'package:equatable/equatable.dart';

class MatchHistory extends Equatable {
  final int played, win, draw, lose;
  final (int from, int against) goals;

  const MatchHistory({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
    required this.goals,
  });

  @override
  List<Object?> get props => [played, win, draw, lose, goals];
}

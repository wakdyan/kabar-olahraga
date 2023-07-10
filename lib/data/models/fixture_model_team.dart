part of 'fixture_model.dart';

class Team extends Equatable {
  final Match home;
  final Match away;

  const Team({
    required this.home,
    required this.away,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      home: Match.fromJson(json['home']),
      away: Match.fromJson(json['away']),
    );
  }

  @override
  List<Object?> get props => [home, away];
}

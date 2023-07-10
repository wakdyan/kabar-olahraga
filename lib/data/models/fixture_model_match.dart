part of 'fixture_model.dart';

class Match extends Equatable {
  final int id;
  final String name;
  final String logo;
  final bool winner;

  const Match({
    required this.id,
    required this.name,
    required this.logo,
    required this.winner,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      winner: json['winner'],
    );
  }

  @override
  List<Object?> get props => [id, name, logo, winner];
}

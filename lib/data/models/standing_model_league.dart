part of 'standing_model.dart';

class League extends Equatable {
  final int id, season;
  final String name, country, logo, flag;

  const League({
    required this.id,
    required this.season,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      season: json['season'],
      name: json['name'],
      country: json['country'],
      logo: json['logo'],
      flag: json['flag'],
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

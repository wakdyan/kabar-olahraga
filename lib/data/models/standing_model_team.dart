part of 'standing_model.dart';

class Team extends Equatable {
  final int id;
  final String name;
  final String logo;

  const Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }

  e.Team toEntity() {
    return e.Team(id: id, name: name, logo: logo);
  }

  @override
  List<Object?> get props => [id, name, logo];
}

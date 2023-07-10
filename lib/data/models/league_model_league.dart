part of 'league_model.dart';

class League extends Equatable {
  final int id;
  final String name;
  final String type;
  final String logo;

  const League(this.id, this.name, this.type, this.logo);

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      json['id'],
      json['name'],
      json['type'],
      json['logo'],
    );
  }

  @override
  List<Object?> get props => [id, name, type, logo];
}

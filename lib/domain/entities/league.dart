import 'package:equatable/equatable.dart';

class League extends Equatable {
  final int id;
  final String name;
  final String logo;
  final String country;
  final String? type;
  final String? season;
  final String? flag;

  const League({
    required this.id,
    required this.name,
    required this.logo,
    required this.country,
    this.type,
    this.season,
    this.flag,
  });

  @override
  List<Object?> get props => [id, name, type, logo, country, season, flag];
}

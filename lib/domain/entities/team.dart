import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final int id;
  final String name;
  final String logo;

  const Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  @override
  List<Object?> get props => [id, name, logo];
}

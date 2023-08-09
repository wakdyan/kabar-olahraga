import 'package:equatable/equatable.dart';

class League extends Equatable {
  final int id;
  final String name;
  final String type;
  final String logo;

  const League(this.id, this.name, this.type, this.logo);

  @override
  List<Object?> get props => [id, name, type, logo];
}

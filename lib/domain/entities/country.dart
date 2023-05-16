import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String code;
  final String flag;

  const Country(this.name, this.code, this.flag);

  @override
  List<Object?> get props => [name, code, flag];
}

part of 'league_model.dart';

class Country extends Equatable {
  final String name;
  final String code;
  final String flag;

  const Country(this.name, this.code, this.flag);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      json['name'],
      json['code'],
      json['flag'],
    );
  }

  @override
  List<Object?> get props => [name, code, flag];
}

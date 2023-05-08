import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final String name;
  final String code;
  final String flag;

  const CountryModel(this.name, this.code, this.flag);

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      json['name'],
      json['code'],
      json['flag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
      'flag': flag,
    };
  }

  @override
  List<Object?> get props => [name, code, flag];
}

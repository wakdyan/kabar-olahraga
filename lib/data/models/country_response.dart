import 'package:equatable/equatable.dart';
import 'package:kabar_olahraga/data/models/country_model.dart';

class CountryResponse extends Equatable {
  final List<CountryModel> countries;

  const CountryResponse(this.countries);

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      List.from(json['response']).map((e) => CountryModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response':
          List<CountryModel>.from(countries).map((e) => e.toJson()).toList()
    };
  }

  @override
  List<Object?> get props => [countries];
}

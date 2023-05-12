import 'package:equatable/equatable.dart';

import 'fixture_model.dart';

class FixtureResponse extends Equatable {
  final List<FixtureModel> fixtures;

  const FixtureResponse(this.fixtures);

  factory FixtureResponse.fromJson(Map<String, dynamic> json) {
    return FixtureResponse(
      List.from(json['response']).map((e) => FixtureModel.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [fixtures];
}

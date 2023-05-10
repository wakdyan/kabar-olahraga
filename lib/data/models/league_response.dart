import 'package:equatable/equatable.dart';

import 'league_model.dart';

class LeagueResponse extends Equatable {
  final List<LeagueModel> leagues;

  const LeagueResponse(this.leagues);

  factory LeagueResponse.fromJson(Map<String, dynamic> json) {
    return LeagueResponse(
      List.from(json['response']).map((e) => LeagueModel.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [leagues];
}

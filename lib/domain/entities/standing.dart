import 'package:equatable/equatable.dart';

import 'league.dart';
import 'standing_detail.dart';

class Standing extends Equatable {
  final League league;
  final List<StandingDetail> standings;

  const Standing({required this.league, required this.standings});

  @override
  List<Object?> get props => [league, standings];
}

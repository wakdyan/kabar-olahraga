part of 'fixture_model.dart';

class Goal extends Equatable {
  final int? home;
  final int? away;

  const Goal(this.home, this.away);

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(json['home'], json['away']);
  }

  @override
  List<Object?> get props => [home, away];
}

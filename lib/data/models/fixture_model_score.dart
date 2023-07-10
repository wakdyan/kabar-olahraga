part of 'fixture_model.dart';

class Score extends Equatable {
  final Goal halfTime;
  final Goal fullTime;
  final Goal extraTime;
  final Goal penalty;

  const Score({
    required this.halfTime,
    required this.fullTime,
    required this.extraTime,
    required this.penalty,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      halfTime: Goal.fromJson(json['halftime']),
      fullTime: Goal.fromJson(json['fulltime']),
      extraTime: Goal.fromJson(json['extratime']),
      penalty: Goal.fromJson(json['penalty']),
    );
  }

  @override
  List<Object?> get props => [halfTime, fullTime, extraTime, penalty];
}

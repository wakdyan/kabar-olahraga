part of 'league_model.dart';

class Season extends Equatable {
  final int year;
  final String start;
  final String end;
  final bool current;
  final Coverage coverage;

  const Season(this.year, this.start, this.end, this.current, this.coverage);

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      json['year'],
      json['start'],
      json['end'],
      json['current'],
      Coverage.fromJson(json['coverage']),
    );
  }

  @override
  List<Object?> get props => [year, start, end, current, coverage];
}

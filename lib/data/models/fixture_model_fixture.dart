part of 'fixture_model.dart';

class Fixture extends Equatable {
  final int id;
  final String? referee;
  final String timezone;
  final String date;
  final int timestamp;
  final Map<String, dynamic> periods;
  final Map<String, dynamic> venue;
  final Map<String, dynamic> status;

  const Fixture({
    required this.id,
    required this.referee,
    required this.timezone,
    required this.date,
    required this.timestamp,
    required this.periods,
    required this.venue,
    required this.status,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'],
      referee: json['referee'],
      timezone: json['timezone'],
      date: json['date'],
      timestamp: json['timestamp'],
      periods: json['periods'],
      venue: json['venue'],
      status: json['status'],
    );
  }

  @override
  List<Object?> get props {
    return [id, referee, timezone, date, timestamp, periods, venue, status];
  }
}

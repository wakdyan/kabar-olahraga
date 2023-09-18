import 'package:equatable/equatable.dart';
import 'package:kabar_olahraga/data/models/standing_model.dart';

class StandingResponse extends Equatable {
  final List<StandingModel> standings;

  const StandingResponse(this.standings);

  factory StandingResponse.fromJson(Map<String, dynamic> json) {
    return StandingResponse(
      List.from(json['response']).map((e) {
        return StandingModel.fromJson(e);
      }).toList(),
    );
  }

  @override
  List<Object?> get props => [standings];
}

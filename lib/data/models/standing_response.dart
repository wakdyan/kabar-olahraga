import 'package:equatable/equatable.dart';
import 'package:kabar_olahraga/data/models/standing_model.dart';

class StandingResponse extends Equatable {
  final StandingModel standing;

  const StandingResponse(this.standing);

  factory StandingResponse.fromJson(Map<String, dynamic> json) {
    return StandingResponse(StandingModel.fromJson(json['response']));
  }

  @override
  List<Object?> get props => [standing];
}

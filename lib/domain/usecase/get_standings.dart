import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/standing.dart';
import '../repositories/footbal_repository.dart';

class GetStandings {
  final FootballRepository _repository;

  const GetStandings(this._repository);

  Future<Either<Failure, Standing?>> execute(int league, int season) {
    return _repository.getStandings(league, season);
  }
}

import 'package:dartz/dartz.dart';
import 'package:kabar_olahraga/domain/repositories/footbal_repository.dart';

import '../../common/failure.dart';
import '../entities/standing.dart';

class GetStandings {
  final FootballRepository _repository;

  const GetStandings(this._repository);

  Future<Either<Failure, List<Standing>>> execute(int league, int season) {
    return _repository.getStandings(league, season);
  }
}

import 'package:dartz/dartz.dart';
import 'package:kabar_olahraga/domain/entities/league.dart';
import 'package:kabar_olahraga/domain/repositories/footbal_repository.dart';

import '../../common/failure.dart';

class GetLeagues {
  final FootballRepository _repository;

  const GetLeagues(this._repository);

  Future<Either<Failure, List<League>>> execute() {
    return _repository.getLeagues();
  }
}

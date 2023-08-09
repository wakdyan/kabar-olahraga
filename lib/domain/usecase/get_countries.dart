import 'package:dartz/dartz.dart';
import 'package:kabar_olahraga/domain/entities/country.dart';
import 'package:kabar_olahraga/domain/repositories/footbal_repository.dart';

import '../../common/failure.dart';

class GetCountries {
  final FootballRepository _repository;

  const GetCountries(this._repository);

  Future<Either<Failure, List<Country>>> execute() {
    return _repository.getCountries();
  }
}

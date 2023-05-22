import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/country.dart';
import '../entities/league.dart';

abstract class FootballRepository {
  Future<Either<Failure, List<Country>>> getCountries();
  Future<Either<Failure, List<League>>> getLeagues();
}

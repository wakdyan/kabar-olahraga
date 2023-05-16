import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/country.dart';

abstract class FootballRepository {
  Future<Either<Failure, List<Country>>> getCountries();
}

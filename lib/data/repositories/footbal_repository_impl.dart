import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:kabar_olahraga/data/data_sources/remote_data_source.dart';
import 'package:kabar_olahraga/domain/entities/country.dart';

import '../../common/exceptions.dart';
import '../../common/failure.dart';
import '../../domain/repositories/footbal_repository.dart';

class FootballRepositoryImpl extends FootballRepository {
  final RemoteDataSource remoteDataSource;

  FootballRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Country>>> getCountries() async {
    try {
      final result = await remoteDataSource.getCountries();
      final countries = result.map((e) => e.toEntity()).toList();
      return Right(countries);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}

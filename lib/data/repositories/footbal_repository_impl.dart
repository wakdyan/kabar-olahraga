import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../common/exceptions.dart';
import '../../common/failure.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/league.dart';
import '../../domain/entities/standing.dart';
import '../../domain/repositories/footbal_repository.dart';
import '../data_sources/remote_data_source.dart';

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

  @override
  Future<Either<Failure, List<League>>> getLeagues(String countryId) async {
    try {
      final result = await remoteDataSource.getLeagues(countryId);
      final leagues = result.map((e) => e.toEntity()).toList();
      return Right(leagues);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<Standing>>> getStandings(
      int league, int season) async {
    try {
      final result = await remoteDataSource.getStandings(league, season);
      final standings = result.standings.map((e) => e.toEntity()).toList();
      return Right(standings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}

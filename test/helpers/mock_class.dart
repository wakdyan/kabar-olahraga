import 'package:http/http.dart';
import 'package:kabar_olahraga/domain/repositories/footbal_repository.dart';
import 'package:kabar_olahraga/domain/usecase/get_leagues.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

class MockFootballRepository extends Mock implements FootballRepository {}

class MockGetLeagues extends Mock implements GetLeagues {}

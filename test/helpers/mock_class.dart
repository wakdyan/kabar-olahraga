import 'package:kabar_olahraga/data/data_sources/remote_data_source.dart';
import 'package:kabar_olahraga/domain/repositories/footbal_repository.dart';
import 'package:kabar_olahraga/domain/usecase/get_leagues.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// import '../presentation/home_module/my_test.dart';

@GenerateMocks(
  [RemoteDataSource, FootballRepository, GetLeagues],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}

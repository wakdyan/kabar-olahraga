import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/data_sources/remote_data_source.dart';
import '../../../data/repositories/footbal_repository_impl.dart';
import '../../../domain/usecase/get_leagues.dart';
import 'controller.dart';

class FootballDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FootballDetailController(
        GetLeagues(
          FootballRepositoryImpl(
            ImplRemoteDataSource(http.Client()),
          ),
        ),
      ),
    );
  }
}

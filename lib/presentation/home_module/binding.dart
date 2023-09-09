import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../data/data_sources/remote_data_source.dart';
import '../../data/repositories/footbal_repository_impl.dart';
import '../../domain/usecase/get_leagues.dart';
import 'controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        GetLeagues(
          FootballRepositoryImpl(
            ImplRemoteDataSource(Client()),
          ),
        ),
      ),
    );
  }
}

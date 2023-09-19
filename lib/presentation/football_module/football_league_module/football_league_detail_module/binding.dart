import 'package:get/get.dart';

import '../../../../data/data_sources/remote_data_source.dart';
import '../../../../data/repositories/footbal_repository_impl.dart';
import '../../../../domain/usecase/get_standings.dart';
import 'controller.dart';

class FootballLeagueDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FootballLeagueDetailController(
        GetStandings(
          FootballRepositoryImpl(Get.find<ImplRemoteDataSource>()),
        ),
      ),
    );
  }
}

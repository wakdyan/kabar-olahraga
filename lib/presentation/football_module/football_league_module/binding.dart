import 'package:get/get.dart';

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
          FootballRepositoryImpl(Get.find<RemoteDataSourceImpl>()),
        ),
      ),
    );
  }
}

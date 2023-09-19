import 'package:get/get.dart';

import '../../data/data_sources/remote_data_source.dart';
import '../../data/repositories/footbal_repository_impl.dart';
import '../../domain/usecase/get_countries.dart';
import 'controller.dart';

class FootballBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FootballController(
        GetCountries(
          FootballRepositoryImpl(Get.find<ImplRemoteDataSource>()),
        ),
      ),
    );
  }
}

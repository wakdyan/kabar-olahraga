import 'package:get/get.dart';

import '../../../common/enum.dart';
import '../../../domain/entities/country.dart';
import '../../../domain/entities/league.dart';
import '../../../domain/usecase/get_leagues.dart';
import '../../../routes/app_page.dart';

class FootballDetailController extends GetxController {
  final GetLeagues _usecase;

  late final Country country;

  var errorMessage = '';
  var leagues = <League>[];
  var requestState = RequestState.idle;

  FootballDetailController(this._usecase);

  @override
  void onInit() {
    country = Get.arguments;
    super.onInit();
  }

  Future<void> getLeagues() async {
    requestState = RequestState.busy;
    update();

    final result = await _usecase.execute(country.code!);
    result.fold(
      (failure) {
        errorMessage = failure.message;
        requestState = RequestState.error;
      },
      (data) {
        leagues = data;
        requestState = RequestState.success;
      },
    );
    update();
  }

  void moveToLeagueDetailPage(League league) {
    Get.toNamed(
      '${Get.currentRoute}${AppRoute.footballLeagueDetail}',
      arguments: league,
    );
  }
}

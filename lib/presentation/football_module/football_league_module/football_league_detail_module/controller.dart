import 'package:get/get.dart';

import '../../../../common/enum.dart';
import '../../../../domain/entities/country.dart';
import '../../../../domain/entities/standing.dart';
import '../../../../domain/usecase/get_standings.dart';

class FootballLeagueDetailController extends GetxController {
  final GetStandings _usecase;

  late final Country country;

  var errorMessage = '';
  var leagues = <Standing>[];
  var requestState = RequestState.idle;

  FootballLeagueDetailController(this._usecase);

  @override
  void onInit() {
    country = Get.arguments;
    super.onInit();
  }

  Future<void> getLeagues() async {
    requestState = RequestState.busy;
    update();

    final result = await _usecase.execute(int.parse(country.code!), 2023);
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
}

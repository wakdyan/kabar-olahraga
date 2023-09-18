import 'package:get/get.dart';

import '../../common/enum.dart';
import '../../domain/entities/country.dart';
import '../../domain/usecase/get_countries.dart';
import '../../routes/app_page.dart';

class FootballController extends GetxController {
  final GetCountries _usecase;

  var errorMessage = '';
  var countries = <Country>[];
  var requestState = RequestState.idle;

  FootballController(this._usecase);

  @override
  void onReady() {
    getCountries();
    super.onReady();
  }

  Future<void> getCountries() async {
    requestState = RequestState.busy;
    update();

    final result = await _usecase.execute();
    result.fold(
      (failure) {
        errorMessage = failure.message;
        requestState = RequestState.error;
      },
      (data) {
        countries = data;
        countries.removeWhere((data) => data.code == null || data.flag == null);
        requestState = RequestState.success;
      },
    );
    update();
  }

  void moveToDetailPage(Country country) {
    Get.toNamed(
      '${AppRoute.football}${AppRoute.footballLeague}',
      arguments: country,
    );
  }
}

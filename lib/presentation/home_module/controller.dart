import 'package:get/get.dart';

import '../../common/enum.dart';
import '../../domain/entities/league.dart';
import '../../domain/usecase/get_leagues.dart';

class HomeController extends GetxController {
  final GetLeagues _usecase;

  var errorMessage = '';
  var leagues = <League>[];
  var requestState = RequestState.idle;

  HomeController(this._usecase);

  Future<void> getLeagues() async {
    requestState = RequestState.busy;
    update();

    final result = await _usecase.execute();
    result.fold(
      (error) {
        errorMessage = error.message;
        requestState = RequestState.error;
      },
      (success) {
        leagues = success;
        requestState = RequestState.success;
      },
    );

    update();
  }
}

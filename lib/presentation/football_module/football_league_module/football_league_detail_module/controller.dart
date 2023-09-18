import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/constants.dart';
import '../../../../common/enum.dart';
import '../../../../domain/entities/league.dart';
import '../../../../domain/entities/standing.dart';
import '../../../../domain/usecase/get_standings.dart';

class FootballLeagueDetailController extends GetxController {
  final GetStandings _usecase;

  late final League league;
  Standing? standing;

  final scrollController = ScrollController();

  var errorMessage = '';
  var requestState = RequestState.idle;
  var isScrolled = false;
  var isFavorited = false;

  late (int value, String label) selectedSeason;

  FootballLeagueDetailController(this._usecase);

  @override
  void onInit() {
    league = Get.arguments;
    selectedSeason = (
      footballSeasons.first['value'],
      footballSeasons.first['label'],
    );
    scrollController.addListener(_positionTracking);
    super.onInit();
  }

  @override
  void onReady() {
    _getStandings(selectedSeason.$1);
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.removeListener(_positionTracking);
    scrollController.dispose();
    super.onClose();
  }

  void _positionTracking() {
    if (scrollController.offset == 0) {
      isScrolled = false;
    } else {
      isScrolled = true;
    }
    update(['team_container']);
  }

  Future<void> _getStandings(int selectedSeason) async {
    requestState = RequestState.busy;
    update();

    final result = await _usecase.execute(league.id, selectedSeason);
    result.fold(
      (failure) {
        errorMessage = failure.message;
        requestState = RequestState.error;
      },
      (data) {
        standing = data;
        requestState = RequestState.success;
      },
    );
    update();
  }

  void onMenuSelected(int value) {
    final season = footballSeasons.where((element) {
      return element.values.contains(value);
    }).first;
    selectedSeason = (season['value'], season['label']);
    _getStandings(selectedSeason.$1);
  }

  void addOrRemoveFavorite() {
    isFavorited = !isFavorited;
    update(['favorite_button']);
  }
}

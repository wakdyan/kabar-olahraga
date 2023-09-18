import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:kabar_olahraga/common/constants.dart';
import 'package:kabar_olahraga/domain/repositories/footbal_repository.dart';
import 'package:kabar_olahraga/domain/usecase/get_countries.dart';
import 'package:kabar_olahraga/domain/usecase/get_leagues.dart';
import 'package:kabar_olahraga/presentation/football_module/module.dart';
import 'package:kabar_olahraga/presentation/home_module/module.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

class MockFootballRepository extends Mock implements FootballRepository {}

class MockGetLeagues extends Mock implements GetLeagues {}

class MockGetCountries extends Mock implements GetCountries {}

class MockHomeController extends GetxController
    with Mock, GetTickerProviderStateMixin
    implements HomeController {
  @override
  TabController get tabController {
    return TabController(length: tabData.length, vsync: this);
  }
}

class MockFootballController extends GetxController
    with Mock
    implements FootballController {}

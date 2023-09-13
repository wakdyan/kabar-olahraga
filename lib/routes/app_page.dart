import 'package:get/get.dart';

import '../presentation/baseball_module/module.dart';
import '../presentation/basketball_module/module.dart';
import '../presentation/football_module/module.dart';
import '../presentation/formula_one_module/module.dart';
import '../presentation/handball_module/module.dart';
import '../presentation/hockey_module/module.dart';
import '../presentation/home_module/module.dart';
import '../presentation/volleyball_module/module.dart';

part 'app_route.dart';

class AppPage {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoute.root,
      page: () => const HomePage(),
      bindings: [
        HomeBinding(),
        BaseballBinding(),
        BasketballBinding(),
        FootballBinding(),
        FormulaOneBinding(),
        HandballBinding(),
        HockeyBinding(),
        VolleyballBinding(),
      ],
      children: [
        GetPage(
          name: AppRoute.baseball,
          page: () => const BaseballPage(),
        ),
        GetPage(
          name: AppRoute.basketball,
          page: () => const BasketballPage(),
        ),
        GetPage(
          name: AppRoute.football,
          page: () => const FootballPage(),
          children: [
            GetPage(
              name: AppRoute.footballDetail,
              binding: FootballDetailBinding(),
              page: () => const FootballDetailPage(),
            ),
          ],
        ),
        GetPage(
          name: AppRoute.formulaOne,
          page: () => const FormulaOnePage(),
        ),
        GetPage(
          name: AppRoute.handball,
          page: () => const HandballPage(),
        ),
        GetPage(
          name: AppRoute.hockey,
          page: () => const HockeyPage(),
        ),
        GetPage(
          name: AppRoute.volleyball,
          page: () => const VolleyballPage(),
        ),
      ],
    ),
  ];
}

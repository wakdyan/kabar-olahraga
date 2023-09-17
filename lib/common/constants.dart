import '../presentation/baseball_module/module.dart';
import '../presentation/basketball_module/module.dart';
import '../presentation/football_module/module.dart';
import '../presentation/formula_one_module/module.dart';
import '../presentation/handball_module/module.dart';
import '../presentation/hockey_module/module.dart';
import '../presentation/volleyball_module/module.dart';

final tabData = <Map<String, dynamic>>[
  {
    'label': 'Football',
    'page': const FootballPage(),
  },
  {
    'label': 'Baseball',
    'page': const BaseballPage(),
  },
  {
    'label': 'Basketball',
    'page': const BasketballPage(),
  },
  {
    'label': 'Formula One',
    'page': const FormulaOnePage(),
  },
  {
    'label': 'Handball',
    'page': const HandballPage(),
  },
  {
    'label': 'Hockey',
    'page': const HockeyPage(),
  },
  {
    'label': 'Volleyball',
    'page': const VolleyballPage(),
  },
];

const footballSeasons = <Map<String, dynamic>>[
  {
    'value': 2023,
    'label': '2023/2024',
  },
  {
    'value': 2022,
    'label': '2022/2023',
  },
  {
    'value': 2021,
    'label': '2021/2022',
  },
  {
    'value': 2020,
    'label': '2020/2021',
  },
  {
    'value': 2019,
    'label': '2019/2020',
  },
];

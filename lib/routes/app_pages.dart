import 'package:get/get.dart';

import '../presentation/home_module/binding.dart';
import '../presentation/home_module/page.dart';

final pages = <GetPage>[
  GetPage(
    name: 'home',
    page: () => const HomePage(),
    binding: HomeBinding(),
  ),
];

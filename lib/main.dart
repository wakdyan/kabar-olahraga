import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'data/data_sources/remote_data_source.dart';
import 'routes/app_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(ImplRemoteDataSource(Client()));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      initialRoute: AppRoute.root,
      getPages: AppPage.pages,
    );
  }
}

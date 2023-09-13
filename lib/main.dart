import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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

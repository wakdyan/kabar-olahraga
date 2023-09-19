import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/enum.dart';
import '../../widgets/error_widget.dart' as w;
import '../../widgets/loader_widget.dart';
import 'controller.dart';

class FootballPage extends GetView<FootballController> {
  const FootballPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('football_page'),
      body: GetBuilder<FootballController>(
        initState: (_) {
          if (controller.countries.isEmpty) controller.getCountries();
        },
        builder: (_) {
          if (controller.requestState == RequestState.busy) {
            return const LoaderWidget();
          } else if (controller.requestState == RequestState.error) {
            return w.ErrorWidget(message: controller.errorMessage);
          } else if (controller.requestState == RequestState.success) {
            return _buildLeagues();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildLeagues() {
    return ListView.separated(
      key: const PageStorageKey('football_list'),
      itemCount: controller.countries.length,
      itemBuilder: (_, index) {
        final country = controller.countries[index];
        return ListTile(
          onTap: () => controller.moveToDetailPage(country),
          leading: SvgPicture.network(
            country.flag!,
            width: 56,
            height: 28,
            fit: BoxFit.fitWidth,
          ),
          title: Text(country.name),
        );
      },
      separatorBuilder: (_, __) => const Divider(indent: 16, endIndent: 16),
    );
  }
}

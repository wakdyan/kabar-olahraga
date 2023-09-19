import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/enum.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/error_widget.dart' as w;
import '../../../widgets/loader_widget.dart';
import 'controller.dart';

class FootballDetailPage extends GetView<FootballDetailController> {
  const FootballDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.country.name),
      ),
      body: GetBuilder<FootballDetailController>(
        initState: (_) {
          if (controller.leagues.isEmpty) controller.getLeagues();
        },
        builder: (_) {
          if (controller.requestState == RequestState.busy) {
            return const LoaderWidget();
          } else if (controller.requestState == RequestState.error) {
            return w.ErrorWidget(message: controller.errorMessage);
          } else if (controller.requestState == RequestState.success) {
            if (controller.leagues.isEmpty) {
              return const EmptyWidget(
                title: 'Ups, enggak ada liga nih',
                subtitle: 'Silahkan lihat liga negara yang lain',
              );
            }
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
      key: const PageStorageKey('football_detail_list'),
      itemCount: controller.leagues.length,
      itemBuilder: (_, index) {
        final league = controller.leagues[index];
        return ListTile(
          onTap: () => controller.moveToLeagueDetailPage(league),
          leading: Container(
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(4),
            child: CachedNetworkImage(
              imageUrl: league.logo,
            ),
          ),
          title: Text(league.name),
        );
      },
      separatorBuilder: (_, __) => const Divider(indent: 16, endIndent: 16),
    );
  }
}

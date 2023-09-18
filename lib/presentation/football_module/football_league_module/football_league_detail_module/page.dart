import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/constants.dart';
import '../../../../common/enum.dart';
import '../../../../widgets/empty_widget.dart';
import '../../../../widgets/error_widget.dart' as w;
import '../../../../widgets/loader_widget.dart';
import 'controller.dart';
import 'widgets/standing_section.dart';

class FootballLeagueDetailPage extends GetView<FootballLeagueDetailController> {
  const FootballLeagueDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<FootballLeagueDetailController>(
          builder: (_) {
            if (controller.requestState == RequestState.busy) {
              return const LoaderWidget();
            } else if (controller.requestState == RequestState.error) {
              return w.ErrorWidget(message: controller.errorMessage);
            } else if (controller.requestState == RequestState.success) {
              return _buildPage();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildPage() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: kToolbarHeight + 80,
          title: const Text('Klasemen'),
          actions: [
            GetBuilder<FootballLeagueDetailController>(
              id: 'favorite_button',
              builder: (_) {
                return IconButton(
                  onPressed: controller.addOrRemoveFavorite,
                  icon: controller.isFavorited
                      ? Icon(
                          Icons.favorite,
                          color: Get.theme.colorScheme.error,
                        )
                      : const Icon(Icons.favorite_outline),
                );
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: ListTile(
                leading: CachedNetworkImage(
                  height: 56,
                  imageUrl: controller.league.logo,
                ),
                title: Text(controller.league.name),
                subtitle: Text(controller.league.country),
                trailing: PopupMenuButton<int>(
                  initialValue: controller.selectedSeason.$1,
                  onSelected: controller.onMenuSelected,
                  itemBuilder: (_) {
                    return [
                      for (var season in footballSeasons)
                        PopupMenuItem(
                          value: season['value'],
                          child: Text(season['label']),
                        ),
                    ];
                  },
                  child: Chip(
                    label: Text(controller.selectedSeason.$2),
                  ),
                ),
              ),
            ),
          ),
        ),
        controller.standing != null
            ? SliverToBoxAdapter(child: _buildStanding())
            : const SliverFillRemaining(
                child: EmptyWidget(
                  imageUrl: 'assets/undraw_no_data.svg',
                  title: 'Tidak ada klasemen',
                  subtitle: 'Silahkan ganti musim yang lain',
                ),
              ),
      ],
    );
  }

  Widget _buildStanding() {
    final standing = controller.standing!;
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: GetBuilder<FootballLeagueDetailController>(
              id: 'team_container',
              builder: (_) {
                return Container(
                  padding: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surface,
                    boxShadow: controller.isScrolled
                        ? const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 1,
                              offset: Offset(3, 0),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Tim',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      for (var data in standing.standings)
                        ListTile(
                          leading: Text('${data.rank}'),
                          title: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: data.team.logo,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  data.team.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              controller: controller.scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StandingSection(
                    label: 'T',
                    data: standing.standings
                        .map((data) => data.matchHistory.played),
                  ),
                  StandingSection(
                    label: 'M',
                    data:
                        standing.standings.map((data) => data.matchHistory.win),
                  ),
                  StandingSection(
                    label: 'S',
                    data: standing.standings
                        .map((data) => data.matchHistory.draw),
                  ),
                  StandingSection(
                    label: 'K',
                    data: standing.standings
                        .map((data) => data.matchHistory.lose),
                  ),
                  StandingSection(
                    label: 'Poin',
                    data: standing.standings.map((data) => data.points),
                  ),
                  StandingSection(
                    label: 'GM',
                    data: standing.standings
                        .map((data) => data.matchHistory.goals.$1),
                  ),
                  StandingSection(
                    label: 'GK',
                    data: standing.standings
                        .map((data) => data.matchHistory.goals.$2),
                  ),
                  StandingSection(
                    label: 'GS',
                    data: standing.standings.map(
                      (data) {
                        return data.matchHistory.goals.$1 -
                            data.matchHistory.goals.$2;
                      },
                    ),
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

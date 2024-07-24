import 'package:flutter/material.dart';
import 'package:rank_everything/src/dashboard/dashboard_view.dart';
import 'package:rank_everything/src/settings/settings_view.dart';
import 'package:rank_everything/src/stats/stats_view.dart';
import 'package:rank_everything/src/widgets/animated_title.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({
    super.key,
  });

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3, initialIndex: 1);
    tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool landscape =
        MediaQuery.of(context).size.width / MediaQuery.of(context).size.height >
            1;

    return Row(
      children: [
        !landscape
            ? Container()
            : NavigationRail(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                onDestinationSelected: (value) =>
                    tabController.animateTo(value),
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.analytics_outlined),
                    selectedIcon: Icon(Icons.analytics),
                    label: Text("Stats"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: Text("Settings"),
                  ),
                ],
                selectedIndex: tabController.index,
              ),
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: landscape
                  ? Theme.of(context).colorScheme.surfaceContainerLow
                  : null,
              title: AnimatedTitle(controller: tabController),
            ),
            body: TabBarView(
              controller: tabController,
              children: const [
                StatsView(),
                DashboardView(),
                SettingsView(),
              ],
            ),
            bottomNavigationBar: landscape
                ? null
                : TabBar(
                    controller: tabController,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(icon: Icon(Icons.bar_chart)),
                      Tab(icon: Icon(Icons.home)),
                      Tab(icon: Icon(Icons.settings)),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

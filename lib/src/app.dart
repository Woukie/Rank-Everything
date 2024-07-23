import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/dashboard_view.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';
import 'package:rank_everything/src/settings/settings_provider.dart';
import 'package:rank_everything/src/stats/search_provider.dart';
import 'package:rank_everything/src/stats/stats_view.dart';

import 'settings/settings_view.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.settingsProvider,
  });

  final SettingsProvider settingsProvider;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => widget.settingsProvider),
        ChangeNotifierProvider(
            create: (_) => SearchProvider(widget.settingsProvider)),
        ChangeNotifierProvider(
            create: (_) => ThingProvider(widget.settingsProvider)),
      ],
      child: Builder(builder: (context) {
        SettingsProvider settingsProvider =
            Provider.of<SettingsProvider>(context);

        Color seedColor = settingsProvider.useSystemColor
            ? settingsProvider.systemColor
            : settingsProvider.color;

        return MaterialApp(
          restorationScopeId: 'app',
          supportedLocales: const [
            Locale('en', ''),
          ],
          theme: ThemeData(
            colorSchemeSeed: seedColor,
            fontFamily: GoogleFonts.fjallaOne().fontFamily,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: seedColor,
            brightness: Brightness.dark,
            fontFamily: GoogleFonts.fjallaOne().fontFamily,
          ),
          themeMode: settingsProvider.theme,
          home: Scaffold(
            appBar: AppBar(
              title: AnimatedTitle(controller: _tabController),
            ),
            bottomNavigationBar: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.bar_chart)),
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
            body: TabBarView(
              controller: _tabController,
              children: const [
                StatsView(),
                DashboardView(),
                SettingsView(),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    super.key,
    required this.controller,
  });

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Settings'),
    );
  }
}

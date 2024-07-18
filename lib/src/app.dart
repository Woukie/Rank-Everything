import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/dashboard_view.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';
import 'package:rank_everything/src/settings/settings_provider.dart';
import 'package:rank_everything/src/stats/search_provider.dart';
import 'package:rank_everything/src/stats/stats_view.dart';

import 'settings/settings_view.dart';

/// The Widget that configures your application.
class App extends StatelessWidget {
  const App({
    super.key,
    required this.settingsProvider,
  });

  final SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settingsProvider),
        ChangeNotifierProvider(create: (_) => ThingProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
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
          theme: ThemeData(colorSchemeSeed: seedColor),
          darkTheme: ThemeData(
            colorSchemeSeed: seedColor,
            brightness: Brightness.dark,
          ),
          themeMode: settingsProvider.theme,
          home: const DefaultTabController(
            length: 3,
            initialIndex: 1,
            child: Scaffold(
              bottomNavigationBar: TabBar(tabs: [
                Tab(icon: Icon(Icons.bar_chart)),
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.settings)),
              ]),
              body: TabBarView(children: [
                StatsView(),
                DashboardView(),
                SettingsView(),
              ]),
            ),
          ),
        );
      }),
    );
  }
}

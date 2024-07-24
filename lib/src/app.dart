import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';
import 'package:rank_everything/src/settings/settings_provider.dart';
import 'package:rank_everything/src/stats/search_provider.dart';

import 'app_root.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.settingsProvider,
  });

  final SettingsProvider settingsProvider;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
          title: "Rank Everything",
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
          home: const AppRoot(),
        );
      }),
    );
  }
}

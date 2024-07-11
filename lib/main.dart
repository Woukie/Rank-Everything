import 'package:flutter/material.dart';
import 'package:rank_everything/src/settings/settings_provider.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsProvider = SettingsProvider();
  await settingsProvider.load();

  runApp(App(settingsProvider: settingsProvider));
}

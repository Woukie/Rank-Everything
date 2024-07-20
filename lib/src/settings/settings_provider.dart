import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';
import 'package:rank_everything/src/stats/search_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_theme/system_theme.dart';

enum NsfwMode {
  hidden,
  blurred,
  shown,
}

class SettingsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ThemeMode _theme = ThemeMode.system;
  NsfwMode _nsfw = NsfwMode.hidden;
  bool _useSystemColor = true;
  Color _color = Colors.blue;
  late Color _systemColor;

  ThemeMode get theme => _theme;
  NsfwMode get nsfw => _nsfw;
  bool get useSystemColor => _useSystemColor;
  Color get color => _color;
  Color get systemColor => _systemColor;

  Future<void> setNsfw(BuildContext context, NsfwMode? nsfw) async {
    if (nsfw == null) return;

    _nsfw = nsfw;
    notifyListeners();

    Provider.of<ThingProvider>(context, listen: false).loadNextThings();
    Provider.of<SearchProvider>(context, listen: false).refresh();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("nsfw", nsfw.name);
  }

  Future<void> setTheme(ThemeMode? theme) async {
    if (theme == null) return;
    _theme = theme;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", theme.name);
  }

  Future<void> setUseSystemColor(bool? useSystemColor) async {
    if (useSystemColor == null) return;
    _useSystemColor = useSystemColor;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("useSystemColor", useSystemColor);
  }

  Future<void> setColor(Color? color) async {
    if (color == null) return;
    _color = color;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("color", color.value);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty('theme', theme));
    properties.add(EnumProperty('nsfw', nsfw));
    properties.add(ColorProperty('color', color));
    properties.add(ColorProperty('systemColor', systemColor));
  }

  Future<void> load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await SystemTheme.accentColor.load();

    _theme = switch (prefs.getString('theme')) {
      "light" => ThemeMode.light,
      "dark" => ThemeMode.dark,
      _ => _theme
    };

    _nsfw = switch (prefs.getString('nsfw')) {
      "blurred" => NsfwMode.blurred,
      "shown" => NsfwMode.shown,
      _ => _nsfw
    };

    int? prefColor = prefs.getInt('color');
    _color = prefColor != null ? Color(prefColor) : _color;

    _useSystemColor = prefs.getBool('useSystemColor') ?? _useSystemColor;

    _systemColor = SystemTheme.accentColor.accent;

    SystemTheme.onChange.listen((event) {
      _systemColor = event.accent;
      notifyListeners();
    });
  }
}

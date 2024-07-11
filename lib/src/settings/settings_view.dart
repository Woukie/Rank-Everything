import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/settings/settings_provider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<ThemeMode>(
              value: settingsProvider.theme,
              onChanged: settingsProvider.setTheme,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
            DropdownButton<NsfwMode>(
              value: settingsProvider.nsfw,
              onChanged: settingsProvider.setNsfw,
              items: const [
                DropdownMenuItem(
                  value: NsfwMode.shown,
                  child: Text('Shown'),
                ),
                DropdownMenuItem(
                  value: NsfwMode.blurred,
                  child: Text('Blurred'),
                ),
                DropdownMenuItem(
                  value: NsfwMode.hidden,
                  child: Text('Hidden'),
                )
              ],
            ),
            Switch(
              value: settingsProvider.useSystemColor,
              onChanged: settingsProvider.setUseSystemColor,
            ),
            settingsProvider.useSystemColor
                ? Container()
                : MaterialColorPicker(
                    onColorChange: (Color color) {
                      settingsProvider.setColor(color);
                    },
                    selectedColor: settingsProvider.color,
                  )
          ],
        ),
      ),
    );
  }
}

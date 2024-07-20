import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/settings/settings_provider.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'setting_item.dart';

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
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingItem(
              title: "Theme",
              body: "Change the app theme",
              child: DropdownButton<ThemeMode>(
                value: settingsProvider.theme,
                onChanged: settingsProvider.setTheme,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark'),
                  )
                ],
              ),
            ),
            SettingItem(
              title: "Content Filtering",
              body: "Change how adult content is filtered",
              child: DropdownButton<NsfwMode>(
                value: settingsProvider.nsfw,
                onChanged: (value) {
                  settingsProvider.setNsfw(context, value);
                },
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
            ),
            SettingItem(
              title: "System Color",
              body: "Use your devices color theme",
              child: Switch(
                value: settingsProvider.useSystemColor,
                onChanged: settingsProvider.setUseSystemColor,
              ),
            ),
            settingsProvider.useSystemColor
                ? Container()
                : GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: MaterialColorPicker(
                                      onColorChange: (Color color) {
                                        settingsProvider.setColor(color);
                                      },
                                      selectedColor: settingsProvider.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: SettingItem(
                      title: "App Color",
                      body: "Choose a custom color for the app",
                      child: CircleColor(
                        color: settingsProvider.color,
                        circleSize: 40,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

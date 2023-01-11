import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body:SettingsList(
          sections: [
            SettingsSection(
              title: Text('Common'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text('Language'),
                  value: Text('English'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: Icon(Icons.format_paint),
                  title: Text('Enable custom theme'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

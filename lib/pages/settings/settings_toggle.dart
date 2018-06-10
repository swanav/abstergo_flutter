import 'package:flutter/material.dart';
import 'package:abstergo_flutter/models/setting.dart';
import 'package:abstergo_flutter/models/settings.dart';
import 'package:abstergo_flutter/actions.dart';

class SettingsToggle extends StatelessWidget {
  final String tag;
  final Setting<bool> setting;
  final toggle;

  SettingsToggle({
    @required this.tag,
    @required this.setting,
    this.toggle,
  });

  onChange(bool value) {
    toggle(SettingsChangeAction(tag, Settings.changeSetting<bool>(setting, value)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(setting.icon),
      title: Text(setting.heading),
      subtitle: Text(setting.description == null ? '' : setting.description),
      trailing: Switch(
        value: setting.value,
        activeColor: Theme.of(context).accentColor,
        onChanged: onChange,
      ),
    );
  }
}

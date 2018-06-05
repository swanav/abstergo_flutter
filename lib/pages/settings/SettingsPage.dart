import 'package:flutter/material.dart';
import 'package:abstergo_flutter/res/strings.dart';
import 'package:abstergo_flutter/pages/settings/SettingsToggle.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.SETTINGS_TITLE),
        centerTitle: false,
        primary: true,
      ),
      body: ListView(children: <Widget>[
        SettingsToggle(
          heading: "Background updates",
          description: "Check for new updates in background",
        ),
      ])
    );
  }
}

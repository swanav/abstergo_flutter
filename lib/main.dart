import 'package:flutter/material.dart';
import 'application.dart';
import 'settings.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final String applicationName = "Oracle";

  final ThemeData theme = new ThemeData(
    primaryColor: Colors.orange,
    accentColor: Colors.cyanAccent,
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: applicationName,
      theme: theme,
      home: new OracleApplication(),
      routes: <String, WidgetBuilder>{
        '/settings': (BuildContext context) => new SettingsPage(),
      },
    );
  }
}

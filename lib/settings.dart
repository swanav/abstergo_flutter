import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: new Text("Settings"),
          centerTitle: true,
        ),
      body: new Container(
        child: new Text("Settings"),
      ),
    );
  }
}

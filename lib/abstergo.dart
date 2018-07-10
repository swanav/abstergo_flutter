import 'package:flutter/material.dart';

import 'package:abstergo_flutter/pages/home/oracle_application.dart';
import 'package:abstergo_flutter/res/strings.dart';

class Abstergo extends StatelessWidget {
  final String applicationName = Strings.APP_TITLE;

  final theme = ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.amber,
    fontFamily: 'Titillium'
  );

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: applicationName,
        theme: theme,
        home: OracleApplication(title: applicationName),
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/pages/home/oracle_application.dart';
import 'package:abstergo_flutter/redux/app_reducer.dart';
import 'package:abstergo_flutter/redux/middleware.dart';
import 'package:abstergo_flutter/res/strings.dart';

class Abstergo extends StatelessWidget {
  final String applicationName = Strings.APP_TITLE;

  final theme = ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.amber,
  );

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
    middleware: [
      loggingMiddleware,
      networkRequestMiddleware,
    ],
  );

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: applicationName,
          theme: theme,
          home: OracleApplication(title: applicationName),
        ),
      );
}

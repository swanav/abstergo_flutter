import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:abstergo_flutter/res/strings.dart';
import 'package:abstergo_flutter/pages/home/OracleApplication.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/AppReducer.dart';
import 'package:abstergo_flutter/Middleware.dart';

class Abstergo extends StatelessWidget {
  final String applicationName = Strings.APP_TITLE;

  final theme = ThemeData(
    primaryColor: Colors.blue,
    accentColor: Colors.amber,
  );

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
    middleware: [
      loggingMiddleware,
      networkRequestMiddleware,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: applicationName,
        theme: theme,
        home: OracleApplication(
          title: applicationName,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

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

  // ignore:
  Persistor<AppState> persistor;
  // ignore:
  Store<AppState> store;

  Abstergo() {
    persistor = Persistor<AppState>(
      storage: FlutterStorage("data.json"),
      decoder: AppState.fromJson,
    );

    store = Store<AppState>(
      appReducer,
      initialState: AppState.loading(),
      middleware: [
        loggingMiddleware,
        networkRequestMiddleware,
        persistor.createMiddleware(),
      ],
    );

    persistor.load(store);
  }

  @override
  Widget build(BuildContext context) => PersistorGate(
        persistor: persistor,
        builder: (context) => StoreProvider<AppState>(
              store: store,
              child: MaterialApp(
                title: applicationName,
                theme: theme,
                home: OracleApplication(title: applicationName),
              ),
            ),
        loading: MaterialApp(
          home: Container(
            child: Scaffold(
              body: Center(
                child: Text("Loading..."),
              ),
            ),
          ),
        ),
      );
}

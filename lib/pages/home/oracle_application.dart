import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:abstergo_flutter/pages/login/login.dart';
import 'package:abstergo_flutter/pages/layout/body.dart';
import 'package:abstergo_flutter/pages/layout/bottom_bar.dart';
import 'package:abstergo_flutter/pages/layout/colors.dart';
import 'package:abstergo_flutter/pages/settings/settings_page.dart';
import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/redux/actions.dart';
import 'package:abstergo_flutter/res/icons.dart';

class OracleApplication extends StatefulWidget {
  final Store<AppState> store;
  final String title;

  OracleApplication({this.store, this.title});

  @override
  createState() => _OracleApplicationState(store: store, title: title);
}

class _OracleApplicationState extends State<OracleApplication>
    with WidgetsBindingObserver {
  final Store<AppState> store;
  final String title;

  _OracleApplicationState({this.store, this.title});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("App Changed Lifecyclestate: $state");
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
        if(!user.hasData || user == null ||user.data == null) {
          return LoginPage();
        }
        print(user.data.email);
        return StoreConnector<AppState, int>(
        converter: (store) => store.state.pageIndex,
        builder: (BuildContext context, int pageIndex) {
          return Scaffold(
            appBar: AppBar(
              elevation: 4.0,
              backgroundColor: colors[pageIndex],
              centerTitle: true,
              title: Text(title),
              leading: _Refresh(),
              actions: <Widget>[
                _Gear(),
              ],
            ),
            body: Body(),
            bottomNavigationBar: BottomBar(),
          );
        });
      },
    );
  }
}

class _Gear extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, VoidCallback>(
        converter: (Store<AppState> store) {
          return () {
            Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage(),
                  ),
                );
          };
        },
        builder: (context, callback) {
          return IconButton(
            onPressed: callback,
            color: Colors.white,
            icon: Icon(AppIcons.SETTINGS),
          );
        },
      );
}

class _Refresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, VoidCallback>(
        converter: (Store<AppState> store) {
          return () {
            return store.dispatch(PersonalInfoFetchAction);
          };
        },
        builder: (context, callback) {
          return IconButton(
            onPressed: callback,
            color: Colors.white,
            icon: Icon(AppIcons.APP_REFRESH),
          );
        },
      );
}

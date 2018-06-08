import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:abstergo_flutter/pages/login/login.dart';
import 'package:abstergo_flutter/pages/layout/Body.dart';
import 'package:abstergo_flutter/pages/layout/BottomBar.dart';
import 'package:abstergo_flutter/pages/settings/SettingsPage.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/Actions.dart';

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
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          if (!vm.isLoggedIn) {
            return LoginPage();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: <Widget>[
                _Refresh(),
                _Gear(),
              ],
            ),
            body: Body(),
            bottomNavigationBar: BottomBar(),
          );
        });
  }
}

class _ViewModel {
  final bool isLoggedIn;

  _ViewModel({this.isLoggedIn});

  static _ViewModel fromStore(Store<AppState> store) {
    bool isLoggedIn;
    if(store.state.session == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = store.state.session.isValid;
    }
    return _ViewModel(isLoggedIn: isLoggedIn);
  }
}

class _Refresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
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
          icon: Icon(Icons.settings),
        );
      },
    );
  }
}

class _Gear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () {
          return store.dispatch(PersonalInfoFetchAction);
        };
      },
      builder: (context, callback) {
        return IconButton(
          onPressed: callback,
          color: Colors.white,
          icon: Icon(Icons.refresh),
        );
      },
    );
  }
}

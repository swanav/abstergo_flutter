import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:abstergo_flutter/pages/login/login.dart';
import 'package:abstergo_flutter/pages/layout/body.dart';
import 'package:abstergo_flutter/pages/layout/bottom_bar.dart';
import 'package:abstergo_flutter/pages/layout/colors.dart';
import 'package:abstergo_flutter/pages/settings/settings_page.dart';
import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/actions.dart';

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
            elevation: 4.0,
            backgroundColor: colors[vm.pageIndex],
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
  }
}

class _ViewModel {
  final bool isLoggedIn;
  final int pageIndex;

  _ViewModel({this.isLoggedIn, this.pageIndex});

  static _ViewModel fromStore(Store<AppState> store) {
    bool isLoggedIn;
    if(store.state.session == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = store.state.session.isValid;
    }
    return _ViewModel(isLoggedIn: isLoggedIn, pageIndex: store.state.pageIndex);
  }
}

class _Gear extends StatelessWidget {
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

class _Refresh extends StatelessWidget {
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

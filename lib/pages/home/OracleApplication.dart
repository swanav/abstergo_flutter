import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:abstergo_flutter/pages/layout/Body.dart';
import 'package:abstergo_flutter/pages/layout/BottomBar.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/Actions.dart';

class OracleApplication extends StatefulWidget {

  final Store<AppState> store;
  final String title;

  OracleApplication({this.store, this.title});

  @override
    createState() => _OracleApplicationState(store: store, title: title);
}

class _OracleApplicationState extends State<OracleApplication> with WidgetsBindingObserver {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          _Gear(),
        ],
      ),
      body: Body(),
      bottomNavigationBar: BottomBar(),
      floatingActionButton: _FAB(),
    );
  }
}

class _Gear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () {
          print("FAB");
          return store.dispatch(PersonalInfoFetchAction);
        };
      },
      builder: (context, callback) {
        return IconButton(
          onPressed: callback,
          icon: Icon(Icons.star),
        );
      },
    );
  }
}


class _FAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return FloatingActionButton(
          onPressed: () => vm.dispatch(PersonalInfoFetchAction),
          elevation: 8.0,
          backgroundColor: Colors.amber,
          child: Icon(Icons.star),
        );
      },
    );
  }
}

class _ViewModel {
  
  final dynamic dispatch;

  _ViewModel({this.dispatch});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      dispatch: store.dispatch
    );
  }
}

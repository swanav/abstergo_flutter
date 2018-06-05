import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/models/Settings.dart';
import 'package:abstergo_flutter/Actions.dart';

class SettingsToggle extends StatelessWidget {

  final String heading;
  final String description;

  SettingsToggle({@required this.heading, this.description});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ListTile(
          title: Text(heading),
          leading: Switch(
            value: vm.settings.updateInBackground,
            activeColor: Theme.of(context).accentColor,
            onChanged: vm.dispatcher(SettingsChangeAction(Settings(updateInBackground: false))),
          ),
        );
      },  
    );
  }
}

class _ViewModel {

  final dynamic dispatcher;
  final Settings settings; 

  _ViewModel({this.dispatcher, this.settings});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      dispatcher: store.dispatch,
      settings: store.state.settings
    );
  }
}
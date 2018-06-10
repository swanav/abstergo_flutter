import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:abstergo_flutter/models/app_state.dart';
import 'package:abstergo_flutter/actions.dart';
import 'package:abstergo_flutter/models/setting.dart';
import 'package:abstergo_flutter/models/settings.dart';
import 'package:abstergo_flutter/res/strings.dart';
import 'package:abstergo_flutter/pages/settings/settings_toggle.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          return Scaffold(
            appBar: AppBar(
              title: Text(Strings.SETTINGS_TITLE),
              centerTitle: true,
              primary: true,
              actions: <Widget>[
                IconButton(
                  onPressed: () {vm.dispatcher(context);},
                  icon: Icon(Icons.exit_to_app),
                  tooltip: "Logout",
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      if (vm.settings.values.elementAt(index)
                          is Setting<bool>) {
                        return SettingsToggle(
                          tag: vm.settings.keys.elementAt(index),
                          setting: vm.settings.values.elementAt(index),
                          toggle: vm.dispatcher,
                        );
                      }
                      if (vm.settings.values.elementAt(index)
                          is Setting<String>) {
                        return SettingsInput(
                          tag: vm.settings.keys.elementAt(index),
                          setting: vm.settings.values.elementAt(index),
                          toggle: vm.dispatcher,
                        );
                      }
                    },
                    itemCount: vm.settings.length,
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: Icon(Icons.error_outline),
                  title: Text(
                    "You cannot change your username and password. Please logout and login again with your new credentials.",
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class _ViewModel {
  final Map<String, Setting> settings;
  final dynamic dispatcher;
  _ViewModel({@required this.settings, @required this.dispatcher});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      settings: store.state.settings,
      dispatcher: (BuildContext context) {
        store.dispatch(LogoutAction);
        Navigator.of(context).pop();
      },
    );
  }
}

class SettingsInput extends StatelessWidget {
  final String tag;
  final Setting<String> setting;
  final toggle;

  SettingsInput({
    @required this.tag,
    @required this.setting,
    this.toggle,
  });

  onChange(String value) {
    toggle(SettingsChangeAction(
        tag, Settings.changeSetting<String>(setting, value)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(setting.icon),
      title: Text(setting.heading),
      // isThreeLine: true,
      subtitle: Text(setting.value != null ? setting.value : 'Not configured'),
    );
  }
}

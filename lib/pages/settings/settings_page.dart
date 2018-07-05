import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:abstergo_flutter/res/icons.dart';
import 'package:abstergo_flutter/res/strings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.SETTINGS_TITLE,
          style: TextStyle(fontFamily: 'ProductSans'),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            icon: Icon(AppIcons.SETTINGS_LOGOUT),
            tooltip: "Logout",
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                // if (vm.settings.values.elementAt(index)
                //     is Setting<bool>) {
                //   return SettingsToggle(
                //     tag: vm.settings.keys.elementAt(index),
                //     setting: vm.settings.values.elementAt(index),
                //     toggle: vm.dispatcher,
                //   );
                // }
                // if (vm.settings.values.elementAt(index)
                //     is Setting<String>) {
                //   return SettingsInput(
                //     tag: vm.settings.keys.elementAt(index),
                //     setting: vm.settings.values.elementAt(index),
                //     toggle: vm.dispatcher,
                //   );
                // }
              },
              itemCount: 0, //vm.settings.length,
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(AppIcons.SETTINGS_ALERT),
            title: Text(
              "You cannot change your username and password. Please logout and login again with your new credentials.",
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

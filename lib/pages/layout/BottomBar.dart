import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:abstergo_flutter/Actions.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/pages/layout/navigation.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return BottomNavigationBar(
          onTap: vm.onTap,
          currentIndex: vm.currentIndex,
          type: BottomNavigationBarType.shifting,
          items: navbarItems
        );
      },
    );
  }
}

class _ViewModel {
  
  dynamic onTap;
  int currentIndex;

  _ViewModel({this.onTap, this.currentIndex});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onTap: (index) {
        store.dispatch(NavigationChangeAction(index));
      },
      currentIndex: store.state.pageIndex,
    );
  }
}

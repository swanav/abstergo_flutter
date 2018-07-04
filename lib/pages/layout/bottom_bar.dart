import 'package:flutter/material.dart';

import 'package:abstergo_flutter/pages/layout/navigation.dart';

class BottomBar extends StatelessWidget {
  final touchHandler;
  final int currentIndex;

  BottomBar({this.touchHandler, @required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: BottomNavigationBar(
        onTap: touchHandler,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        items: navbarItems,
      ),
    );
  }
}

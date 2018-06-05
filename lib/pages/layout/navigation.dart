import 'package:flutter/material.dart';
import 'package:abstergo_flutter/res/icons.dart';
import 'package:abstergo_flutter/res/strings.dart';

List<BottomNavigationBarItem> navbarItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: Icon(AppIcons.NAV_COURSES),
      title: Text(Strings.COURSES_TITLE),
      backgroundColor: Colors.deepOrange
  ),
  BottomNavigationBarItem(
      icon: Icon(AppIcons.NAV_CLASSES),
      title: Text(Strings.CLASSES_TITLE),
      backgroundColor: Colors.orange
  ),
  BottomNavigationBarItem(
      icon: Icon(AppIcons.NAV_PROFILE),
      title: Text(Strings.PROFILE_TITLE),
      backgroundColor: Colors.blue
  ),
];

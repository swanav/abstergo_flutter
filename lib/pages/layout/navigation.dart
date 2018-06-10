import 'package:flutter/material.dart';
import 'package:abstergo_flutter/res/icons.dart';
import 'package:abstergo_flutter/res/strings.dart';
import 'package:abstergo_flutter/pages/layout/colors.dart';

List<BottomNavigationBarItem> navbarItems = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(AppIcons.NAV_COURSES),
    title: Text(Strings.COURSES_TITLE),
    backgroundColor: colors[0],
  ),
  BottomNavigationBarItem(
    icon: Icon(AppIcons.NAV_CLASSES),
    title: Text(Strings.CLASSES_TITLE),
    backgroundColor: colors[1],
  ),
  BottomNavigationBarItem(
    icon: Icon(AppIcons.NAV_PROFILE),
    title: Text(Strings.PROFILE_TITLE),
    backgroundColor: colors[2],
  ),
];

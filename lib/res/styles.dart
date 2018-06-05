import 'package:flutter/material.dart';
import 'package:abstergo_flutter/res/keys.dart';

class Styles {
  static const Map<String, TextStyle> Profile = {
    Keys.NAME: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
    Keys.ENROLLMENT_NUMBER: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
    Keys.SEMESTER: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
    Keys.BRANCH: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
    'body-head': TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
    'body': TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.black)
  };
}

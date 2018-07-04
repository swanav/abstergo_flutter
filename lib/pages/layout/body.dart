import 'package:flutter/material.dart';

import 'package:abstergo_flutter/pages/courses/courses_page.dart';
import 'package:abstergo_flutter/pages/classes/classes_page.dart';
import 'package:abstergo_flutter/pages/profile/profile_page.dart';

class Body extends StatelessWidget {
  final int pageIndex;

  Body({this.pageIndex});

  @override
  Widget build(BuildContext context) {
    switch (pageIndex) {
      case 0:
        return CoursesPage();
      case 1:
        return ClassesPage();
      case 2:
        return ProfilePage();
      default:
        return ClassesPage();
    }
  }
}

import 'package:flutter/material.dart';

List<BottomNavigationBarItem> navbarItems = <BottomNavigationBarItem>[
  new BottomNavigationBarItem(
      icon: new Icon(Icons.library_books),
      title: new Text("Courses"),
      backgroundColor: Colors.red
  ),
  new BottomNavigationBarItem(
      icon: new Icon(Icons.developer_board),
      title: new Text("Classes"),
      backgroundColor: Colors.orange
  ),
  new BottomNavigationBarItem(
      icon: new Icon(Icons.face),
      title: new Text("Profile"),
      backgroundColor: Colors.blue
  ),
];
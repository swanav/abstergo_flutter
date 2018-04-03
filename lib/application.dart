import 'package:flutter/material.dart';
import 'navigation.dart';
import 'profile.dart';
import 'classes.dart';
import 'courses.dart';

//=================================================================
class OracleApplication extends StatefulWidget {
  @override
  createState() => new OracleApplicationState();
}

class OracleApplicationState extends State<OracleApplication> {
  int currentIndex = 2;
  String day = "MON";
  final List<String> _pageTitle = [
    "Courses",
    "Classes",
    "Profile",
  ];
  final List<Widget> _pageBody = [
    new CoursesPage(),
    new ClassesPage(),
    new ProfilePage(),
  ];
  void _onNavItemSelected(int newIndex) {
    setState(() => currentIndex = newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          _pageTitle[currentIndex],
          style: new TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.settings),
            color: Colors.white,
            onPressed: (() => Navigator.of(context).pushNamed('/settings')),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: _pageBody[currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: _onNavItemSelected,
        items: navbarItems,
      ),
    );
  }
}

//=================================================================

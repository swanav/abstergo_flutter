import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:abstergo_flutter/pages/login/login.dart';
import 'package:abstergo_flutter/pages/layout/body.dart';
import 'package:abstergo_flutter/pages/layout/bottom_bar.dart';
import 'package:abstergo_flutter/pages/layout/colors.dart';
import 'package:abstergo_flutter/pages/settings/settings_page.dart';
import 'package:abstergo_flutter/res/icons.dart';
import 'package:abstergo_flutter/services/fetch_semester_info.dart';
import 'package:abstergo_flutter/services/fetch_exam_grades.dart';
import 'package:abstergo_flutter/services/fetch_exam_marks.dart';
import 'package:abstergo_flutter/services/fetch_profile.dart';

class OracleApplication extends StatefulWidget {
  final String title;

  OracleApplication({this.title});

  @override
  createState() => _OracleApplicationState();
}

class _OracleApplicationState extends State<OracleApplication>
    with WidgetsBindingObserver {
  int pageIndex;

  _OracleApplicationState({this.pageIndex = 1});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("App Changed Lifecyclestate: $state");
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void pageChanger(int newIndex) {
    print(pageIndex);
    if (this.pageIndex != newIndex) {
      setState(() {
        this.pageIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
        if (!user.hasData) {
          return LoginPage();
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 4.0,
            backgroundColor: colors[pageIndex],
            centerTitle: true,
            title: Text(
              widget.title,
              style: TextStyle(fontFamily: 'ProductSans'),
            ),
            leading: _Refresh(),
            actions: <Widget>[
              _Gear(),
            ],
          ),
          body: Body(pageIndex: pageIndex),
          bottomNavigationBar: BottomBar(
            currentIndex: pageIndex,
            touchHandler: pageChanger,
          ),
        );
      },
    );
  }
}

class _Gear extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage(),
                ),
              );
        },
        color: Colors.white,
        icon: Icon(AppIcons.SETTINGS),
      );
}

class _Refresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          print("Fetch... ");
          fetchSemesterInfo();
          fetchExamMarks();
          fetchExamGrades();
          fetchSubGroupInfo();
        },
        color: Colors.white,
        icon: Icon(AppIcons.APP_REFRESH),
      );
}

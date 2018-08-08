import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:abstergo_flutter/models/class_details.dart';
import 'package:abstergo_flutter/pages/classes/day_view.dart';

class ClassesPage extends StatefulWidget {
  @override
  createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage>
    with SingleTickerProviderStateMixin {
  static final List<String> days = ["MON", "TUE", "WED", "THU", "FRI"];

  final List<Tab> myTabs =
      List.generate(5, (int index) => Tab(text: days[index]));

  Map<String, List<ClassDetails>> timeTable;
  TabController _tabController;

  String semesterCode;
  String subGroup;

  @override
  void initState() {
    super.initState();
    int today = DateTime.now().weekday;
    today == 6 || today == 7 ? today = 1 : today = today;

    _tabController = TabController(
      initialIndex: (today - 1),
      length: myTabs.length,
      vsync: this,
    );
    initialize();
  }

  void initialize() async {
    final config = await RemoteConfig.instance;
    await config.fetch(expiration: const Duration(hours: 24));
    await config.activateFetched();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var snapshot =
        await Firestore.instance.collection('profile').document(user.uid).get();
    setState(() {
      this.semesterCode = config.getString('current_semester');
      this.subGroup = snapshot.data["subGroup"];
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        tabs: myTabs,
        indicatorColor: Colors.blue,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black87,
        labelStyle: TextStyle(fontWeight: FontWeight.w500),
        indicatorWeight: 1.0,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w300),
        controller: _tabController,
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          String day = tab.text;
          return DayView(
            semesterCode: semesterCode,
            subGroup: subGroup,
            day: day,
          );
        }).toList(),
      ),
    );
  }
}

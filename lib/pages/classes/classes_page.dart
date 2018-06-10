import 'package:flutter/material.dart';
import 'package:abstergo_flutter/models/class_details.dart';
import 'package:abstergo_flutter/pages/classes/day_view.dart';

class ClassesPage extends StatefulWidget {
  @override
  createState() => new _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage>
    with SingleTickerProviderStateMixin {
  static final List<String> days = ["MON", "TUE", "WED", "THU", "FRI"];

  final List<Tab> myTabs =
      new List.generate(5, (int index) => new Tab(text: days[index]));

  Map<String, List<ClassDetails>> timeTable;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    int today = new DateTime.now().weekday;
    today == 6 || today == 7 ? today = 1 : today = today;

    _tabController = new TabController(
      initialIndex: (today - 1),
      length: myTabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new TabBar(
        tabs: myTabs,
        indicatorColor: Colors.blue,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black87,
        labelStyle: new TextStyle(fontWeight: FontWeight.w500),
        indicatorWeight: 1.0,
        unselectedLabelStyle: new TextStyle(fontWeight: FontWeight.w300),
        controller: _tabController,
      ),
      body: new TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          String day = tab.text;
          return new DayView(day);
        }).toList(),
      ),
    );
  }
}

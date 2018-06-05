import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:abstergo_flutter/models/class_details.dart';

class ClassesPage extends StatefulWidget {
  @override
  createState() => new _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> with SingleTickerProviderStateMixin {

  static final List<String> days = ["MON", "TUE", "WED", "THU", "FRI"];

  final List<Tab> myTabs = new List.generate(5, (int index) => new Tab(text:days[index]));

  Map<String, List<ClassDetails>> timeTable;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    int today = new DateTime.now().weekday;
    today==6||today==7?today=1:today=today;

    _tabController = new TabController(initialIndex: (today-1), length: myTabs.length, vsync: this);
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
          unselectedLabelColor: Colors.grey,
          labelStyle:new TextStyle(fontWeight: FontWeight.bold),
          indicatorWeight: 2.0,
          unselectedLabelStyle: new TextStyle(fontWeight: FontWeight.normal),
          controller: _tabController,
        ),
        body: new TabBarView(
          controller: _tabController,
          children: myTabs.map((Tab tab) {
            String day = tab.text;
            return new DayView(day);
          }).toList(),
        )
    );
  }
}

class DayView extends StatelessWidget {
  final day;

  DayView(this.day);

  List<Widget> dayViewGenerator(dynamic classes) {
    List<Widget> days = new List();
    for(int i = 0; i < 2*classes.length-1; i++) {
      i%2==0?days.add(new DayViewRow(classes[i~/2])):days.add(new Divider());
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {

    return new StreamBuilder(
      stream: Firestore.instance.collection('schedule')
          .document('2019')
          .getCollection('ELE')
          .document('6')
          .getCollection('1718EVESEM')
          .document(day)
          .snapshots,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Time Table Unavailable');

        return new ListView (
          children: dayViewGenerator(snapshot.data.data['classes'])
        );
      }
    );
  }
}

class DayViewRow extends StatelessWidget {
  ClassDetails details;

  final TextStyle titleStyle = new TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w500);
  final TextStyle textStyle = new TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w300);
  final TextStyle timeStyle = new TextStyle(fontWeight: FontWeight.w100);

  DayViewRow(Map details) {
    this.details = new ClassDetails.fromMap(details);
  }

  @override
  Widget build (BuildContext context) {
    return new Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.blue,
                    child: new CircleAvatar(
                      radius: 44.0,
                      backgroundColor: Colors.white,
                      child: new Text(details.classTime, style: timeStyle)
                    )
                )
            ),
            new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(details.courseName, style: titleStyle),
                    new Text(details.venue, style: textStyle),
                    new Text(details.facultyName, style: textStyle)
                  ],
                )
            ),
            new Container(
              child: new Text(details.classType, style: textStyle),
            )
          ]
      )
    );
  }
}







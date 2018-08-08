import 'package:flutter/material.dart';
import 'package:abstergo_flutter/models/class_details.dart';

class DayViewRow extends StatelessWidget {
  final ClassDetails details;
  final int day;

  final TextStyle titleStyle = new TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
  final TextStyle textStyle = new TextStyle(
    fontSize: 14.0,
    color: Colors.black,
    fontWeight: FontWeight.w300,
  );
  final TextStyle timeStyle = new TextStyle(
    fontWeight: FontWeight.w100,
  );

  DayViewRow({this.details, this.day});

  double _calculateProgress(DateTime instant) {
    if(details.duration == 1) {
      if (instant.hour > details.hour) {
        return 1.0;
      } else if(instant.hour < details.hour) {
        return 0.0;
      } else {
        return instant.minute/60.0;
      }
    } else if(details.duration == 2) {
      if(instant.hour > details.hour + 1) {
        return 1.0;
      } else if(instant.hour < details.hour) {
        return 0.0;
      } else {
        if(instant.hour == details.hour) {
          return instant.minute / 120.0;
        } else {
          return (instant.minute+60.0)/120.0;
        }
      }
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    Color color = Colors.amber;
    double progress;
    if (today.weekday == day) {
      progress = _calculateProgress(today);
      if (progress == 1.0) {
        color = Colors.greenAccent;
      } else if (progress == 0.0) {
        color = Colors.amber;
      } else {
        color = Colors.blue;
      }
    }

    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 44.0,
                      backgroundColor: Colors.white,
                      child: Text(details.classTime, style: timeStyle),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(details.courseName, style: titleStyle),
                      Text(details.venue, style: textStyle),
                      Text(details.facultyName, style: textStyle)
                    ],
                  ),
                ),
                Container(
                  child: Text(details.classType, style: textStyle),
                )
              ],
            ),
          ),
          today.weekday == day
              ? Container(
                  height: 2.0,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.amber,
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

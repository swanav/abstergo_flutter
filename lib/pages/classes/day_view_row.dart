import 'package:flutter/material.dart';
import 'package:abstergo_flutter/models/class_details.dart';

class DayViewRow extends StatelessWidget {
  final ClassDetails details;

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

  DayViewRow(this.details);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Card(
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CoursesInfo extends StatelessWidget {
  final double cgpa;

  final String username;

  CoursesInfo({this.cgpa, this.username = "Thaparian"});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hello, ${username.split(" ").first}!",
              style: TextStyle(fontSize: 24.0),
            ),
            Row(
              children: <Widget>[
                Text(
                  "Your current CGPA is",
                  style: TextStyle(fontSize: 16.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    "${(cgpa.toStringAsPrecision(3))}",
                    style: TextStyle(fontFamily: 'Comfortaa', fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

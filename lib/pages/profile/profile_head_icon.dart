import 'package:flutter/material.dart';

class ProfileHeadIcon extends StatelessWidget {
  final String text;

  ProfileHeadIcon(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      child: CircleAvatar(
        backgroundColor: Colors.amber,
        child: new Text(
          text.substring(0, 1),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 46.0,
          ),
        ),
        minRadius: 40.0,
      ),
    );
  }
}

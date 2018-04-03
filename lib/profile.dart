import 'package:flutter/material.dart';
import 'services/fetch_time_table.dart';
class ProfilePage extends StatelessWidget {
  FetchTimeTable fetchTimeTable =
    new FetchTimeTable("2019", "ELE", "6", "1718EVESEM");
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text("Profile", style: new TextStyle(fontWeight: FontWeight.w100))
    );
  }
}

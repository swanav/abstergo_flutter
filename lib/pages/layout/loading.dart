import 'package:flutter/material.dart';

class Loading extends StatelessWidget {

  final Color color;

  Loading({this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

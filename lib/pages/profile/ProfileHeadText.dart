import 'package:flutter/material.dart';

import 'package:abstergo_flutter/res/styles.dart';

class ProfileHeadText extends StatelessWidget {
  final String text;
  final String style;

  ProfileHeadText(this.text, this.style);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 3.0),
        child: Text(text, style: Styles.Profile[style]));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:abstergo_flutter/pages/courses/courses_info.dart';

import 'package:abstergo_flutter/pages/courses/semester_cards.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';

class ColorChoices {
  static const List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.purple,
    Colors.teal,
    Colors.lime,
    Colors.cyan,
    Colors.amber,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.purple,
    Colors.teal,
    Colors.lime,
    Colors.cyan,
  ];
}

class CourseContent extends StatefulWidget {
  final List<Map> semesters;
  final double cgpa;
  final String username;

  CourseContent({this.semesters, this.cgpa, this.username});

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  Color backgroundColor;
  Tween<Color> colorTween;

  @override
  void initState() {
    super.initState();
    colorTween =
        ColorTween(begin: ColorChoices.colors[0], end: ColorChoices.colors[1]);
    backgroundColor = ColorChoices.colors[0];
  }

  handleScrollEvents(int page, double percent) {
    colorTween.begin = ColorChoices.colors[page];
    colorTween.end = ColorChoices.colors[page + 1];
    setState(() {
      backgroundColor = colorTween.lerp(percent);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.semesters == null) {
      return Loading();
    }

    final double _width = MediaQuery.of(context).size.width;

    return Container(
      color: backgroundColor,
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: CoursesInfo(
                      cgpa: widget.cgpa,
                      username: widget.username,
                    ),
                  ),
                  Container(
                    height: 350.0,
                    width: _width,
                    child: SemesterCards(
                      semesters: widget.semesters,
                      scrollHandler: handleScrollEvents,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

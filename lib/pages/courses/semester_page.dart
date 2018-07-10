import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';

import 'package:abstergo_flutter/pages/courses/course_list.dart';
import 'package:abstergo_flutter/pages/layout/sgpa.dart';
import 'package:abstergo_flutter/res/icons.dart';

class SemesterPage extends StatefulWidget {
  final String examCode;
  final List<Course> courses;
  final List<ExamGrade> grades;
  final num sgpa;

  SemesterPage(
      {this.examCode, this.grades, this.courses, this.sgpa});

  @override
  _SemesterPageState createState() => _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage>
    with TickerProviderStateMixin {
  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;

  @override
  void initState() {

    percentComplete = (widget.sgpa.isNaN? 0 : widget.sgpa)/ 10;
    barPercent = percentComplete;
    animationBar = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {
          barPercent = animT.lerp(animationBar.value);
        });
      });
    animT = Tween<double>(begin: percentComplete, end: percentComplete);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: widget.examCode + "_background",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                AppIcons.NAV_BACK,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              Hero(
                tag: widget.examCode + "_more_vert",
                child: Material(
                  color: Colors.transparent,
                  type: MaterialType.transparency,
                  child: IconButton(
                    icon: Icon(
                      AppIcons.NAV_MORE,
                      color: Colors.grey,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: widget.examCode + "_icon",
                      child: SGPA(widget.sgpa),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: widget.examCode + "_number_of_tasks",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "Semester",
                          style: TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: widget.examCode + "_title",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          widget.examCode,
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: widget.examCode + "_progress_bar",
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: LinearProgressIndicator(
                                value: barPercent,
                                backgroundColor: Colors.grey.withAlpha(50),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.cyan),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                  (widget.sgpa.isNaN ? 0 : widget.sgpa * 10)
                                          .toStringAsPrecision(3) +
                                      "%"),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                CourseList(examCode: widget.examCode),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/semester/CourseItem.dart';
import 'package:abstergo_flutter/pages/layout/SGPA.dart';

class SemesterPage extends StatefulWidget {
  final String examCode;
  final List<Course> courses;
  final List<ExamGrade> grades;
  final List<ExamMark> marks;
  final num sgpa;

  SemesterPage(
      {this.examCode, this.marks, this.grades, this.courses, this.sgpa});

  @override
  _SemesterPageState createState() => new _SemesterPageState();
}

class _SemesterPageState extends State<SemesterPage>
    with TickerProviderStateMixin {
  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;
  AnimationController scaleAnimation;

  @override
  void initState() {
    scaleAnimation = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
        lowerBound: 0.0,
        upperBound: 1.0);

    percentComplete = widget.sgpa / 10;
    barPercent = percentComplete;
    animationBar = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {
          barPercent = animT.lerp(animationBar.value);
        });
      });
    animT = new Tween<double>(begin: percentComplete, end: percentComplete);
    scaleAnimation.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Hero(
          tag: widget.examCode + "_background",
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(0.0),
            ),
          ),
        ),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              new Hero(
                tag: widget.examCode + "_more_vert",
                child: new Material(
                  color: Colors.transparent,
                  type: MaterialType.transparency,
                  child: new IconButton(
                    icon: new Icon(
                      Icons.more_vert,
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
                new Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.examCode + "_icon",
                      child: SGPA(widget.sgpa),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.examCode + "_number_of_tasks",
                      child: new Material(
                        color: Colors.transparent,
                        child: new Text(
                          "Semester",
                          style: new TextStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.examCode + "_title",
                      child: new Material(
                        color: Colors.transparent,
                        child: new Text(
                          widget.examCode,
                          style: new TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.examCode + "_progress_bar",
                      child: new Material(
                        color: Colors.transparent,
                        child: new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new LinearProgressIndicator(
                                value: barPercent,
                                backgroundColor: Colors.grey.withAlpha(50),
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.cyan),
                              ),
                            ),
                            new Padding(
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
                Expanded(
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: new ListView.builder(
                      padding: const EdgeInsets.all(0.0),
                      itemBuilder: (BuildContext context, int index) {
                        Course course = widget.courses[index];
                        ExamGrade grade;
                        List<ExamMark> marks;
                        if (widget.marks != null) {
                          marks = widget.marks?.where((mark) => mark.subjectCode == course.code)?.toList();
                        }
                        if (widget.grades != null) {
                          try {
                            grade = widget.grades?.firstWhere((grade) => grade.subjectCode == course.code);
                          } catch (e) {
                            grade = null;
                          }
                        }
                        return new CourseItem(
                          course: course,
                          grade: grade,
                          marks: marks,
                        );
                      },
                      itemCount: widget.courses?.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

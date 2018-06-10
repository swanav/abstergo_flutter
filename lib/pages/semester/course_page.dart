import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/layout/grade.dart';

class CoursePage extends StatefulWidget {
  final Course course;
  final List<ExamMark> marks;
  final ExamGrade grade;

  CoursePage({this.course, this.marks, this.grade});

  @override
  _CoursePageState createState() => new _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with TickerProviderStateMixin {
  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;
  AnimationController scaleAnimation;

  @override
  void initState() {
    scaleAnimation = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
        lowerBound: 0.0,
        upperBound: 1.0);

    percentComplete = (widget.grade == null)
        ? 0.0
        : widget.grade.getGradePoint().toDouble() / 10;
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
          tag: widget.course.code + "_background",
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
                tag: widget.course.code + "_more_vert",
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
                Container(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.course.code + "_grade",
                      child: Grade(widget.grade),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: new Align(
                    alignment: Alignment.bottomRight,
                    child: new Hero(
                      tag: widget.course.code + "_credits",
                      child: new Material(
                        color: Colors.transparent,
                        child: new Text(
                          "${widget.course.credits.toStringAsPrecision(2)} Credits",
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.course.code + "_code",
                      child: _CourseCode(widget.course.code),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.course.code + "_name",
                      child: _CourseName(widget.course.name),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: new Align(
                    alignment: Alignment.bottomLeft,
                    child: new Hero(
                      tag: widget.course.code + "_progress_bar",
                      child: new Material(
                        color: Colors.transparent,
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                              child: new LinearProgressIndicator(
                                value: barPercent,
                                backgroundColor: Colors.grey.withAlpha(50),
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.cyan),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(((widget.grade == null ||
                                              widget.grade
                                                  .getGradePoint()
                                                  .isNaN)
                                          ? 0
                                          : widget.grade.getGradePoint() * 10)
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
                    child: _MarksList(widget.marks),
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

class _CourseCode extends StatelessWidget {
  final String courseCode;

  _CourseCode(this.courseCode);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        courseCode,
      ),
    );
  }
}

class _CourseName extends StatelessWidget {
  final String courseName;

  _CourseName(this.courseName);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        courseName,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}

class _MarksList extends StatelessWidget {
  final List<ExamMark> marks;

  _MarksList(this.marks);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        ExamMark mark = marks[index];
        return ListTile(
          title: Text(mark.event),
          trailing: Text("${mark.obtainedMarks}/${mark.fullMarks}"),
          onTap: () {},
        );
      },
      itemCount: marks.length,
    );
  }
}

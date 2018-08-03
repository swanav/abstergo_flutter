import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/layout/grade.dart';
import 'package:abstergo_flutter/res/icons.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';

class CoursePage extends StatefulWidget {
  final String examCode;
  final Course course;
  final ExamGrade grade;

  CoursePage({@required this.examCode, @required this.course, this.grade});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> with TickerProviderStateMixin {
  double percentComplete;
  AnimationController animationBar;
  double barPercent = 0.0;
  Tween<double> animT;
  AnimationController scaleAnimation;

  @override
  void initState() {
    scaleAnimation = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 250),
        lowerBound: 0.0,
        upperBound: 1.0);

    percentComplete = (widget.grade == null)
        ? 0.0
        : widget.grade.getGradePoint().toDouble() / 10;
    barPercent = percentComplete;
    animationBar = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {
          barPercent = animT.lerp(animationBar.value);
        });
      });
    animT = Tween<double>(begin: 0.0, end: percentComplete);
    scaleAnimation.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: widget.course.subjectCode + "_background",
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
                tag: widget.course.subjectCode + "_more_vert",
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
                Container(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: widget.course.subjectCode + "_grade",
                      child: Grade(widget.grade),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Hero(
                      tag: widget.course.subjectCode + "_credits",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          "${widget.course.credits.toStringAsPrecision(2)} Credits",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: widget.course.subjectCode + "_code",
                      child: _CourseCode(widget.course.subjectCode),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: widget.course.subjectCode + "_name",
                      child: _CourseName(widget.course.subjectName),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: widget.course.subjectCode + "_progress_bar",
                      child: _MarksBar(grade: widget.grade),
                    ),
                  ),
                ),
                Expanded(
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: _MarksList(
                      examCode: widget.examCode,
                      course: widget.course,
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

class _MarksList extends StatefulWidget {
  final String examCode;
  final Course course;
  _MarksList({this.examCode, this.course});

  @override
  State<StatefulWidget> createState() => _MarksListState();
}

class _MarksListState extends State<_MarksList> {
  FirebaseUser user;
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        this.user = user;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Loading();
    }

    return StreamBuilder(
      stream: Firestore.instance
          .collection('exam')
          .document(user.uid)
          .collection(widget.examCode)
          .document(widget.course.subjectCode)
          .collection('marks')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }

        List<DocumentSnapshot> marks = List.from(snapshot.data.documents);

        if(marks.length == 0) {
          return Text("No marks data for this subject.");
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            ExamMark mark = ExamMark.fromMap(Map.from(marks[index].data));
            return ListTile(
              title: Text(mark.event),
              trailing: Text("${mark.obtainedMarks}/${mark.fullMarks}"),
              onTap: () {},
            );
          },
          itemCount: marks.length,
        );
      },
    );
  }
}

class _MarksBar extends StatelessWidget {
  final ExamGrade grade;

  _MarksBar({@required this.grade});

  double get barPercent =>
      (grade == null) ? 0.0 : grade.getGradePoint().toDouble() / 10;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: LinearProgressIndicator(
              value: barPercent,
              backgroundColor: Colors.grey.withAlpha(50),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(((grade == null || grade.getGradePoint().isNaN)
                        ? 0
                        : grade.getGradePoint() * 10)
                    .toStringAsPrecision(3) +
                "%"),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';

class CoursePage extends StatelessWidget {
  final Course course;
  final List<ExamMark> marks;
  final ExamGrade grade;

  CoursePage({this.course, this.marks, this.grade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Subject Details"),
      ),
      primary: true,
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: "code-${course.code}",
            child: _CourseCode(course.code),
          ),
          Hero(
            tag: "name-${course.code}",
            child: _CourseName(course.name),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Hero(
                tag: "grade-${course.code}",
                child: _Grade(grade),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: _MarksList(marks),
            ),
          )
        ],
      )),
    );
  }
}

class _CourseCode extends StatelessWidget {
  final String courseCode;

  _CourseCode(this.courseCode);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          courseCode,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

class _CourseName extends StatelessWidget {
  final String courseName;

  _CourseName(this.courseName);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(
          courseName,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
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

class _Grade extends StatelessWidget {
  final ExamGrade grade;

  _Grade(this.grade);

  Color _getColor() {
    switch (grade.gradeObtained) {
      case 'A+':
        return Colors.green;
      case 'A':
        return Colors.deepOrange;
      case 'A-':
        return Colors.orange;
      case 'B':
        return Colors.teal;
      case 'B-':
        return Colors.purple;
      case 'C':
        return Colors.blue;
      case 'C-':
        return Colors.pink;
      case 'E':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text("Grade"),
          ),
          grade == null
              ? Text("Awaited")
              : CircleAvatar(
                  backgroundColor: _getColor(),
                  foregroundColor: Colors.white,
                  minRadius: 24.0,
                  child: Text(grade.gradeObtained),
                ),
        ],
      ),
    );
  }
}

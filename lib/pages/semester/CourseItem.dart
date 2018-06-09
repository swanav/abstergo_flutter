import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/semester/CoursePage.dart';

class CourseItem extends StatelessWidget {
  CourseItem({@required this.course, this.grade, this.marks});

  final Course course;
  final ExamGrade grade;
  final List<ExamMark> marks;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: "${course.code}_code",
                    child: _CourseCode(course.code),
                  ),
                  Hero(
                    tag: "name${course.code}_name",
                    child: _CourseName(course.name),
                  ),
                ],
              ),
            ),
            Hero(
              tag: "${course.code}_grade",
              child: _Grade(grade),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CoursePage(
                      course: course,
                      marks: marks,
                      grade: grade,
                    ),
              ),
            );
      },
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
      child: Text(
        courseCode,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
          color: Colors.black
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
      child: Text(
        courseName,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14.0,
        ),
      ),
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
          grade == null
              ? Text("Awaited")
              : CircleAvatar(
                  backgroundColor: _getColor(),
                  foregroundColor: Colors.white,
                  radius: 18.0,
                  child: Text(grade.gradeObtained),
                ),
        ],
      ),
    );
  }
}

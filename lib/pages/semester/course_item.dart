import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/semester/course_page.dart';
import 'package:abstergo_flutter/pages/layout/grade.dart';

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
                    tag: "${course.subjectCode}_code",
                    child: _CourseCode(course.subjectCode),
                  ),
                  Hero(
                    tag: "name${course.subjectCode}_name",
                    child: _CourseName(course.subjectName),
                  ),
                ],
              ),
            ),
            Hero(
              tag: "${course.subjectCode}_grade",
              child: Grade(grade),
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

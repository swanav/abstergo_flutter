import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/semester/SemesterPage.dart';

class SemesterCard extends StatelessWidget {
  final String examCode;
  final List<Course> courses;
  final List<ExamMark> examMarks;
  final List<ExamGrade> examGrades;
  final double sgpa;

  SemesterCard({
    this.examCode,
    this.examGrades,
    this.examMarks,
    this.courses,
    this.sgpa,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Ink(
        child: Center(
          child: Hero(
            tag: examCode,
            child: Material(
              color: Colors.transparent,
              child: Text(
                examCode,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => SemesterPage(
                      examCode: examCode,
                      courses: courses,
                      marks: examMarks,
                      grades: examGrades,
                      sgpa: sgpa,
                    ),
              ),
            );
      },
      enableFeedback: true,
    );
  }
}

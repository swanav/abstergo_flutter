import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';

import 'package:abstergo_flutter/pages/courses/course_content.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, num> gradePoints = Map();
    return CourseContent(
      examGrades: List<ExamGrade>(),
      examMarks: List<ExamMark>(),
      semesters: Map<Semester, List<Course>>(),
      gradePoints: gradePoints,
    );
  }
}

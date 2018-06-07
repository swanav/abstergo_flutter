import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/courses/SemesterCard.dart';

class CourseContent extends StatelessWidget {
  final List<ExamMark> examMarks;
  final List<ExamGrade> examGrades;
  final Map<Semester, List<Course>> semesters;
  final Map<String, num> gradePoints;

  CourseContent(
      {this.examGrades, this.examMarks, this.semesters, this.gradePoints});

  @override
  Widget build(BuildContext context) {
    if (semesters == null) {
      return Container(
        child: Center(
          child: Text("Courses"),
        ),
      );
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250.0,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                child: LayoutBuilder(
                  builder:
                      (BuildContext context, BoxConstraints vpConstraints) {
                    String examCode = semesters.keys.elementAt(index).code;

                    List<ExamGrade> grades =
                        examGrades?.where((grade) => grade.examCode == examCode)?.toList();
                    List<ExamMark> marks =
                        examMarks?.where((mark) => mark.examCode == examCode)?.toList();
                    return Card(
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: vpConstraints.maxWidth,
                          minHeight: vpConstraints.maxHeight,
                        ),
                        child: SemesterCard(
                          examCode: examCode,
                          examGrades: grades,
                          examMarks: marks,
                          courses: semesters[semesters.keys.elementAt(index)],
                          sgpa: gradePoints[examCode],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            childCount: semesters.length,
          ),
        ),
      ],
    );
  }
}

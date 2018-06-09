import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/models/AppState.dart';
import 'package:abstergo_flutter/pages/courses/CourseContent.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        Map<String, num> gradePoints = Map();
        try {
          if (vm.semesters != null) {
            vm.semesters.forEach((Semester sem, List<Course> courses) {
              num totalPoints = 0;
              num totalCredits = 0;
              vm.examGrades
                  .where((ExamGrade grade) => grade.examCode == sem.code)
                  .forEach((ExamGrade grade) {
                final x = courses
                    .where((Course c) => c.code == grade.subjectCode)
                    .first;
                totalCredits += x.credits;
                totalPoints += grade.getGradePoint() * x.credits;
              });
              num sgpa = totalPoints / totalCredits;
              gradePoints[sem.code] = sgpa;
            });
          }
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(e.toString()),
                duration: Duration(seconds: 2),
                backgroundColor: Colors.black45,
              ));
        }

        return CourseContent(
          examGrades: vm.examGrades,
          examMarks: vm.examMarks,
          semesters: vm.semesters,
          gradePoints: gradePoints,
        );

        // return MyHomePage(title: 'Todo');

      },
    );
  }
}

class _ViewModel {
  final List<ExamMark> examMarks;
  final List<ExamGrade> examGrades;
  final Map<Semester, List<Course>> semesters;

  _ViewModel({this.examGrades, this.examMarks, this.semesters});

  static _ViewModel fromStore(Store<AppState> store) => _ViewModel(
        examGrades: store.state.examGrades,
        examMarks: store.state.examMarks,
        semesters: store.state.semesters,
      );
}

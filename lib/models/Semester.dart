import 'package:tkiosk/tkiosk.dart';

class Semester {

  String examCode;
  List<ExamMark> examMarks;
  List<ExamGrade> examGrades;

  Semester(this.examCode, {this.examMarks, this.examGrades});
}
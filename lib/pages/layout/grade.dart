import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';

class Grade extends StatelessWidget {
  final ExamGrade grade;

  Grade(this.grade);

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
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: CircleAvatar(
        backgroundColor: grade == null ? Theme.of(context).primaryColorDark:_getColor(),
        foregroundColor: Colors.white,
        radius: 24.0,
        child: Text((grade == null) ? "-" : grade?.gradeObtained),
      ),
    );
  }
}

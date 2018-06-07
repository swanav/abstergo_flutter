import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/semester/CourseItem.dart';

class SemesterPage extends StatelessWidget {
  final String examCode;
  final List<Course> courses;
  final List<ExamGrade> grades;
  final List<ExamMark> marks;
  final num sgpa;

  SemesterPage({this.examCode, this.marks, this.grades, this.courses, this.sgpa});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Semester Details"),
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Hero(
                  tag: examCode,
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          examCode,
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _SGPA(sgpa),
                ],
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      Course course = courses[index];
                      ExamGrade grade;  
                      List<ExamMark> courseMarks;
                      if(marks != null) {
                        courseMarks = marks?.where((mark) => mark.subjectCode == course.code)?.toList();                    
                      }                   
                      if(grades != null) {
                        try {
                          grade = grades?.firstWhere((grade) => grade.subjectCode == course.code);
                        }
                        catch(e) {
                          grade = null;
                        }
                      }
                      
                      return new CourseItem(
                        course: course,
                        grade: grade,
                        marks: courseMarks,
                      );
                    },
                    itemCount: courses?.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SGPA extends StatelessWidget {
  final num sgpa;

  _SGPA(this.sgpa);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text("Grade Point"),
          ),
          sgpa.isNaN
              ? Text("Awaited")
              : CircleAvatar(
                  minRadius: 24.0,
                  child: Text(sgpa.toStringAsPrecision(3)),
                ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/pages/semester/semester_page.dart';
import 'package:abstergo_flutter/pages/courses/semester_card.dart';
import 'package:abstergo_flutter/animations/custom_scroll_physics.dart';

class ColorChoices {
  static const List<Color> colors = [
    Colors.amber,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
    Colors.purple,
    Colors.teal,
    Colors.lime,
    Colors.cyan
  ];
}

class CourseContent extends StatefulWidget {
  final List<ExamMark> examMarks;
  final List<ExamGrade> examGrades;
  final Map<Semester, List<Course>> semesters;
  final Map<String, num> gradePoints;

  CourseContent(
      {this.examGrades, this.examMarks, this.semesters, this.gradePoints});

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {

  ScrollController scrollController;
  Color backgroundColor;
  Tween<Color> colorTween;
  int currentPage = 0;
  Color constBackColor;

  @override
  void initState() {
    super.initState();
    colorTween = new ColorTween(
        begin: ColorChoices.colors[0], end: ColorChoices.colors[1]);
    backgroundColor = ColorChoices.colors[0];
    scrollController = new ScrollController();
    scrollController.addListener(() {
      ScrollPosition position = scrollController.position;
      ScrollDirection direction = position.userScrollDirection;
      int page = position.pixels ~/
          (position.maxScrollExtent / (widget.semesters.length.toDouble() - 1));
      double pageDo = (position.pixels /
          (position.maxScrollExtent / (widget.semesters.length.toDouble() - 1)));
      double percent = pageDo - page;
      if (direction == ScrollDirection.reverse) {
        //page begin
        if (widget.semesters.length - 1 < page + 1) {
          return;
        }
        colorTween.begin = ColorChoices.colors[page];
        colorTween.end = ColorChoices.colors[page + 1];
        setState(() {
          backgroundColor = colorTween.lerp(percent);
        });
      } else if (direction == ScrollDirection.forward) {
        //+1 begin page end
        if (widget.semesters.length - 1 < page + 1) {
          return;
        }
        colorTween.begin = ColorChoices.colors[page];
        colorTween.end = ColorChoices.colors[page + 1];
        setState(() {
          backgroundColor = colorTween.lerp(percent);
        });
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.semesters == null) {
      return Container(
        child: Center(
          child: Text("Courses"),
        ),
      );
    }

    final double _width = MediaQuery.of(context).size.width;

    return Container(
      color: backgroundColor,
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 350.0,
                    width: _width,
                    child: new ListView.builder(
                      itemBuilder: (context, index) {
                        EdgeInsets padding = const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 20.0, bottom: 30.0);
                        String examCode = widget.semesters.keys.elementAt(index).code;

                        List<ExamGrade> grades = widget.examGrades
                            ?.where((grade) => grade.examCode == examCode)
                            ?.toList();
                        List<ExamMark> marks = widget.examMarks
                            ?.where((mark) => mark.examCode == examCode)
                            ?.toList();
                        List<Course> courses =
                            widget.semesters[widget.semesters.keys.elementAt(index)];
                        num sgpa = widget.gradePoints[examCode];
                        
                        return new Padding(
                          padding: padding,
                          child: new InkWell(
                            onTap: () {
                              Navigator.of(context).push(new PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      SemesterPage(
                                        examCode: examCode,
                                        courses: courses,
                                        marks: widget.examMarks,
                                        grades: widget.examGrades,
                                        sgpa: sgpa,
                                      ),
                                  transitionsBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    Widget child,
                                  ) {
                                    return new SlideTransition(
                                      position: new Tween<Offset>(
                                        begin: const Offset(0.0, 1.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: new SlideTransition(
                                        position: new Tween<Offset>(
                                          begin: Offset.zero,
                                          end: const Offset(0.0, 1.0),
                                        ).animate(secondaryAnimation),
                                        child: child,
                                      ),
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 500)));
                            },
                            child: SemesterCard(
                              examCode: examCode,
                              examGrades: grades,
                              examMarks: marks,
                              courses: courses,
                              sgpa: sgpa,
                            ),
                          ),
                        );
                      },
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      scrollDirection: Axis.horizontal,
                      physics: new CustomScrollPhysics(numOfItems: widget.semesters.length.toDouble() -1),
                      controller: scrollController,
                      itemExtent: _width - 80,
                      itemCount: widget.semesters.length,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

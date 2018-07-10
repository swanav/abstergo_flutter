import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';

import 'package:abstergo_flutter/pages/courses/semester_page.dart';
import 'package:abstergo_flutter/pages/courses/semester_card.dart';
import 'package:abstergo_flutter/pages/layout/loading.dart';
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
  final List<Map> semesters;
  final double cgpa;

  CourseContent({this.semesters, this.cgpa});

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
          (position.maxScrollExtent /
              (widget.semesters.length.toDouble() - 1)));
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
      return Loading();
    }

    final double _width = MediaQuery.of(context).size.width;

    return Container(
      color: backgroundColor,
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 150.0,
                            child: Card(
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 24.0),
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        "${(widget.cgpa==null?0.0:widget.cgpa)}",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            fontSize: 32.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 350.0,
                    width: _width,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        EdgeInsets padding = const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 20.0, bottom: 30.0);
                        String examCode =
                            widget.semesters.elementAt(index)['code'];
                        num sgpa = widget.semesters.elementAt(index)['sgpa'];
                        sgpa == null ? sgpa = 0.0 : sgpa;

                        return Padding(
                          padding: padding,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      SemesterPage(
                                        examCode: examCode,
                                        sgpa: sgpa,
                                      ),
                                  transitionsBuilder: (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    Widget child,
                                  ) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.0, 1.0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: SlideTransition(
                                        position: Tween<Offset>(
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
                              sgpa: sgpa,
                            ),
                          ),
                        );
                      },
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      scrollDirection: Axis.horizontal,
                      physics: CustomScrollPhysics(
                          numOfItems: widget.semesters.length.toDouble() - 1),
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

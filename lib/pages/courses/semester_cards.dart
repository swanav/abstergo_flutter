import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:abstergo_flutter/pages/courses/semester_page.dart';
import 'package:abstergo_flutter/pages/courses/semester_card.dart';
import 'package:abstergo_flutter/services/calculator.dart';

class SemesterCards extends StatefulWidget {
  final List<Map> semesters;
  final dynamic scrollHandler;

  SemesterCards({this.semesters, this.scrollHandler});

  @override
  _SemesterCardsState createState() => _SemesterCardsState();
}

class _SemesterCardsState extends State<SemesterCards> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    double fraction = 0.8;
    pageController = PageController(viewportFraction: fraction);
    pageController.addListener(() {
      ScrollPosition position = pageController.position;
      int page = position.pixels~/(position.viewportDimension*fraction); 
      double percent = (position.pixels/(position.viewportDimension*fraction))%1;
      widget.scrollHandler(page, percent);      
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (BuildContext context, int index) {
        Map<dynamic, dynamic> semester = widget.semesters.elementAt(index);
        String examCode = semester['code'];
        num sgpa = semester['sgpa'];
        if (sgpa == null) {
          sgpa = 0.0;
          calculateSgpa(examCode);
        }
        return Padding(
          padding:
              EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0, bottom: 24.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
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
                  transitionDuration: const Duration(milliseconds: 750)));
            },
            child: SemesterCard(
              examCode: examCode,
              sgpa: sgpa,
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      physics: PageScrollPhysics(),
      controller: pageController,
      itemCount: widget.semesters.length,
    );
  }
}

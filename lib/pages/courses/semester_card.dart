import 'package:flutter/material.dart';

import 'package:abstergo_flutter/pages/layout/sgpa.dart';
import 'package:abstergo_flutter/res/icons.dart';

class SemesterCard extends StatelessWidget {
  final String examCode;
  final double sgpa;

  SemesterCard({
    this.examCode,
    this.sgpa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(70),
            offset: const Offset(3.0, 10.0),
            blurRadius: 15.0,
          ),
        ],
      ),
      height: 250.0,
      child: Stack(
        children: <Widget>[
          Hero(
            tag: examCode + "_background",
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: examCode + "_icon",
                        child: SGPA(sgpa),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.topRight,
                          child: Hero(
                            tag: examCode + "_more_vert",
                            child: Material(
                              color: Colors.transparent,
                              type: MaterialType.transparency,
                              child: IconButton(
                                icon: Icon(
                                  AppIcons.NAV_MORE,
                                  color: Colors.grey,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: examCode + "_number_of_tasks",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(" Semester"),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Hero(
                      tag: examCode + "_title",
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          examCode,
                          style: TextStyle(fontSize: 30.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Hero(
                    tag: examCode + "_progress_bar",
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: LinearProgressIndicator(
                              value: sgpa / 10,
                              backgroundColor: Colors.grey.withAlpha(50),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.cyan),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text((sgpa.isNaN ? 0 : sgpa * 10)
                                    .toStringAsPrecision(3) +
                                "%"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

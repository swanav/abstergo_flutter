import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  @override
  createState() => new _CoursesPageState();
}



class _CoursesPageState extends State<CoursesPage> {

  List<SemesterListItem> _semesterList = [
    new SemesterListItem(card: new SemesterCard(), isExpanded: true, gpa: 9.03, semesterNumber: 5),
    new SemesterListItem(card: new SemesterCard(), isExpanded: false, gpa: 8.84, semesterNumber: 4),
    new SemesterListItem(card: new SemesterCard(), isExpanded: false, gpa: 8.75, semesterNumber: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: new ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _semesterList[index].isExpanded = !isExpanded;
                });
              },
              children: _semesterList.map((SemesterListItem item) {
                return new ExpansionPanel(
                    isExpanded: item.isExpanded,
                    headerBuilder: item.headerBuilder,
                    body: item.card
                );
              }).toList()
            )
    );
  }
}

class SemesterCard extends StatelessWidget {

  SemesterCard();

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: new Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new ListBody(
                      children: [
                        new SubjectRow(
                          subjectName: "Digital Signal Processing Fundamentals",
                          gradeObtained: "A",
                          credits: 3.5,
                        ),
                        new SubjectRow(
                          subjectName: "Engineering Electromagnetics",
                          gradeObtained: "B",
                          credits: 3.5,
                        ),
                        new SubjectRow(
                          subjectName: "Transmission and Distribution of Power",
                          gradeObtained: "B",
                          credits: 3.5,
                        ),
                        new SubjectRow(
                          subjectName: "Measurement and Transducers",
                          gradeObtained: "A-",
                          credits: 4.0,
                        ),
                        new SubjectRow(
                          subjectName: "Alternating Current Machines",
                          gradeObtained: "A-",
                          credits: 4.5,
                        ),
                        new SubjectRow(
                          subjectName: "Innovation and Entrepreneurship",
                          gradeObtained: "A-",
                          credits: 4.5,
                        ),
                        new SubjectRow(
                          subjectName: "Power Electronics",
                          gradeObtained: "A",
                          credits: 4.5,
                        ),
                      ]
                  )
                ]
            )
        )
    );
  }
}

class SubjectRow extends StatelessWidget {

  final String subjectName;
  final String gradeObtained;
  final double credits;

  SubjectRow({this.subjectName, this.gradeObtained, this.credits});

  final TextStyle titleStyle = new TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0);
  final TextStyle contentStyle = new TextStyle(fontWeight: FontWeight.w300, fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: new Row(
              children: <Widget>[
                new Expanded(
                    child: new Text(subjectName, style: titleStyle)
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: new Text(gradeObtained, style: contentStyle,),
                ),
                new Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: new Text("$credits credits", style: contentStyle,),
                ),
              ]
          )
      )
    );
  }
}

class SemesterListItem {
  bool isExpanded;
  SemesterCard card;
  double gpa;
  int semesterNumber;

  SemesterListItem({this.card, this.isExpanded = false, this.semesterNumber, this.gpa});

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return new Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: new Row(
              children: [
                new Expanded(
                  child: new Text("SEMESTER $semesterNumber", style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.w100)),
                  //padding: const EdgeInsets.symmetric(horizontal: 4.0),
                ),
                new Container(
                  child: new Text("$gpa", style: new TextStyle(fontSize: 14.0)),
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                ),
              ]
          )
      );
    };
  }
}
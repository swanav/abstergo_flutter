class ClassDetails {
  String courseName;
  String courseCode;
  String venue;
  String facultyName;
  String classType;
  String classTime;

  ClassDetails(this.courseName, this.venue, this.facultyName, this.classType, this.classTime, {this.courseCode} );

  ClassDetails.fromMap(Map<dynamic, dynamic> data) {
    courseName = data["courseName"];
    courseCode = data["courseCode"];
    venue = data["venue"];
    facultyName = data["faculty"];
    classType = data["type"];
    classTime = data["time"];
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> details = new Map();
    details = {
      'courseName': courseName,
      'courseCode': courseCode,
      'venue': venue,
      'faculty': facultyName,
      'time': classTime,
      'type': classType
    };
    return details;
  }

}

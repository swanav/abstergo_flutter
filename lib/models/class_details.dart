class ClassDetails {
  String courseName;
  String courseCode;
  String venue;
  String facultyName;
  String classType;
  String classTime;
  int hour;
  int duration;

  ClassDetails({
    this.courseName,
    this.venue,
    this.facultyName,
    this.classType,
    this.classTime,
    this.courseCode,
    this.hour,
    this.duration,
  });

  ClassDetails.fromMap(Map<dynamic, dynamic> data) {
    courseName = data["courseName"];
    courseCode = data["courseCode"];
    venue = data["venue"];
    facultyName = data["faculty"];
    classType = data["type"];
    classTime = data["time"];
    hour = data["hour"];
    duration = data["duration"];
  }

  Map<String, String> toMap() {
    return {
      'courseName': courseName,
      'courseCode': courseCode,
      'venue': venue,
      'faculty': facultyName,
      'time': classTime,
      'type': classType
    };
  }
}

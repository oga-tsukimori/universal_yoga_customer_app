class Class {
  int classId;
  String className;
  String date;
  String image;
  String teacherName;
  int timestamp;

  Class({
    required this.classId,
    required this.className,
    required this.date,
    required this.image,
    required this.teacherName,
    required this.timestamp,
  });

  factory Class.fromMap(Map<String, dynamic> data) {
    return Class(
      classId: data['classId'],
      className: data['className'],
      date: data['date'],
      image: data['image'],
      teacherName: data['teacherName'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'className': className,
      'date': date,
      'image': image,
      'teacherName': teacherName,
      'timestamp': timestamp,
    };
  }
}

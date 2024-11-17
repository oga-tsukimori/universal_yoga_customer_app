// A model class representing a Class entity.
//
// This class contains information about a specific class, including its ID,
// course ID, date, teacher, and name.

class Class {
  // The unique identifier for the class.
  int classId;

  // The name of the class.
  String className;

  // The date of the class.
  String date;

  // The image of the class.
  String image;

  // The name of the teacher conduction the class.
  String teacherName;

  // The timestamp of the class.
  int timestamp;

  // Creates a new instance of the [Class] model.
  //
  // All parameters are required except for [name], which defaults to an empty string.
  Class({
    required this.classId,
    required this.className,
    required this.date,
    required this.image,
    required this.teacherName,
    required this.timestamp,
  });

  // Creates a new instance of the [Class] model from a map of key-value pairs.
  //
  // The [data] parameter is a map containing the class data, and the [id] parameter
  // is the unique identifier for the class.
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

  // Converts the [Class] instance to a map of key-value pairs.
  //
  // This method is useful for serializing the class data to a format that can be
  // easily stored or transmitted.
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

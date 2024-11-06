// models/class_instance_model.dart
class Class {
  String id;
  String courseId;
  String date;
  String teacher;
  String name;

  Class({
    required this.id,
    required this.courseId,
    required this.date,
    required this.teacher,
    this.name = '',
  });

  factory Class.fromMap(Map<String, dynamic> data, String id) {
    return Class(
      id: id,
      courseId: data['courseId'],
      name: data['name'] ?? '',
      date: data['date'],
      teacher: data['teacher'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'name': name,
      'date': date,
      'teacher': teacher,
    };
  }
}

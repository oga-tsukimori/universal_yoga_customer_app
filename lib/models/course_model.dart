import 'class_model.dart';

// A model class representing a Course.
//
// This class contains details about a course such as its id, day, time,
// capacity, duration, price, type, and description.
class Course {
  // The unique identifier for the course.
  String id;

  // The maximum number of participants allowed in the course.
  int capacity;

  // The type of the course (e.g., Yoga, Pilates).
  String classType;

  // The unique identifier for the course.
  int courseId;

  // A brief name of the course.
  String courseName;

  // The day of the week the course is scheduled.
  String dayOfWeek;

  // A brief description of the course.
  String description;

  // The duration of the course.
  String duration;

  // A list of classes associated with the course.
  List<Class> itemList;

  // The price of the course.
  double pricing;

  // The time of day the course is scheduled.
  String timeOfDay;

  // The timestamp of the course.
  int timestamp;

  // Creates a new Course instance.
  //
  // All fields are required except for [description], which defaults to an
  // empty string if not provided.
  Course({
    required this.id,
    required this.capacity,
    required this.classType,
    required this.courseId,
    required this.courseName,
    required this.dayOfWeek,
    required this.description,
    required this.duration,
    required this.itemList,
    required this.pricing,
    required this.timeOfDay,
    required this.timestamp,
  });

  // Creates a new Course instance from a map.
  //
  // The [data] parameter is a map containing the course details, and the [id]
  // parameter is the unique identifier for the course.
  factory Course.fromMap(Map<String, dynamic> data, String id) {
    return Course(
      id: id,
      capacity: data['capacity'] ?? 0,
      classType: data['classType'] ?? '',
      courseId: data['courseId'] ?? 0,
      courseName: data['courseName'] ?? '',
      dayOfWeek: data['dayOfWeek'] ?? '',
      description: data['description'] ?? '',
      duration: data['duration'] ?? '0',
      itemList: (data['itemList'] as List)
          .map((item) => Class.fromMap(item))
          .toList(),
      pricing: data['pricing'] ?? 0.0,
      timeOfDay: data['timeOfDay'] ?? '',
      timestamp: data['timestamp'] ?? 0,
    );
  }

  // Converts the Course instance to a map.
  //
  // This method returns a map containing the course details, which can be
  // used for serialization.
  Map<String, dynamic> toMap() {
    return {
      'capacity': capacity,
      'classType': classType,
      'courseId': courseId,
      'courseName': courseName,
      'dayOfWeek': dayOfWeek,
      'description': description,
      'duration': duration,
      'itemList': itemList.map((item) => item.toMap()).toList(),
      'pricing': pricing,
      'timeOfDay': timeOfDay,
      'timestamp': timestamp,
    };
  }

  // Returns a string representation of the Course instance.
  //
  // This method is useful for debugging and logging purposes.
  @override
  String toString() {
    return 'Course{id: $id, capacity: $capacity, classType: $classType, courseId: $courseId, courseName: $courseName, dayOfWeek: $dayOfWeek, description: $description, duration: $duration, itemList: $itemList, pricing: $pricing, timeOfDay: $timeOfDay, timestamp: $timestamp}';
  }
}

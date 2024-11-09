// A model class representing a Course.
//
// This class contains details about a course such as its id, day, time,
// capacity, duration, price, type, and description.
class Course {
  // The unique identifier for the course.
  String id;

  // The day the course is scheduled.
  String day;

  // The time the course is scheduled.
  String time;

  // The maximum number of participants allowed in the course.
  int capacity;

  // The duration of the course in minutes.
  int duration;

  // The price of the course.
  double price;

  // The type of the course (e.g., Yoga, Pilates).
  String type;

  // A brief description of the course.
  String description;

  // Creates a new Course instance.
  //
  // All fields are required except for [description], which defaults to an
  // empty string if not provided.
  Course({
    required this.id,
    required this.day,
    required this.time,
    required this.capacity,
    required this.duration,
    required this.price,
    required this.type,
    this.description = '',
  });

  // Creates a new Course instance from a map.
  //
  // The [data] parameter is a map containing the course details, and the [id]
  // parameter is the unique identifier for the course.
  factory Course.fromMap(Map<String, dynamic> data, String id) {
    return Course(
      id: id,
      day: data['day'],
      time: data['time'],
      capacity: data['capacity'],
      duration: data['duration'],
      price: data['price'],
      type: data['type'],
      description: data['description'] ?? '',
    );
  }

  // Converts the Course instance to a map.
  //
  // This method returns a map containing the course details, which can be
  // used for serialization.
  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'time': time,
      'capacity': capacity,
      'duration': duration,
      'price': price,
      'type': type,
      'description': description,
    };
  }

  // Returns a string representation of the Course instance.
  //
  // This method is useful for debugging and logging purposes.
  @override
  String toString() {
    return 'Course{id: $id, day: $day, time: $time, capacity: $capacity, duration: $duration, price: $price, type: $type, description: $description}';
  }
}

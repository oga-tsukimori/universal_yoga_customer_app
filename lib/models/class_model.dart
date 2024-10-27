// models/class_model.dart
class YogaClass {
  String id;
  String day;
  String time;
  int capacity;
  int duration;
  double price;
  String type;
  String description;

  YogaClass({
    required this.id,
    required this.day,
    required this.time,
    required this.capacity,
    required this.duration,
    required this.price,
    required this.type,
    this.description = '',
  });

  factory YogaClass.fromMap(Map<String, dynamic> data, String id) {
    return YogaClass(
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
}

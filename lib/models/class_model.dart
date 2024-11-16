// A model class representing a Class entity.
//
// This class contains information about a specific class, including its ID,
// course ID, date, teacher, and name.
class Class {
  // The unique identifier for the class.
  String id;

  // The image of the class.
  String image;

  // The date of the class.
  String date;

  // The name of the teacher conducting the class.
  String teacher;

  // The name of the class. Defaults to an empty string if not provided.
  String name;

  // Creates a new instance of the [Class] model.
  //
  // All parameters are required except for [name], which defaults to an empty string.
  Class({
    required this.id,
    required this.image,
    required this.date,
    required this.teacher,
    this.name = '',
  });

  // Creates a new instance of the [Class] model from a map of key-value pairs.
  //
  // The [data] parameter is a map containing the class data, and the [id] parameter
  // is the unique identifier for the class.
  factory Class.fromMap(Map<String, dynamic> data, String id) {
    return Class(
      id: id,
      image: data['image'],
      name: data['class_name'] ?? '',
      date: data['date'],
      teacher: data['teacher'],
    );
  }

  // Converts the [Class] instance to a map of key-value pairs.
  //
  // This method is useful for serializing the class data to a format that can be
  // easily stored or transmitted.
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'class_name': name,
      'date': date,
      'teacher': teacher,
    };
  }
}

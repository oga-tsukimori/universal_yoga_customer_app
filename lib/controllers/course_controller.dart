// controllers/course_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../models/course_model.dart';
import '../models/class_model.dart';

class CourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var courses = <Course>[].obs;
  var courseClasses =
      <String, List<Class>>{}.obs; // Map to store classes for each course
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  void fetchCourses() async {
    isLoading.value = true;
    var courseSnapshot = await _firestore.collection('courses').get();
    var courseList = courseSnapshot.docs
        .map((doc) => Course.fromMap(doc.data(), doc.id))
        .toList();
    courses.assignAll(courseList);
    isLoading.value = false;
  }

  void fetchClasses(String courseId) async {
    isLoading.value = true;
    var classSnapshot = await _firestore
        .collection('classes')
        .where('courseId', isEqualTo: courseId)
        .get();
    var classList = classSnapshot.docs
        .map((doc) => Class.fromMap(doc.data(), doc.id))
        .toList();
    courseClasses[courseId] = classList;
    isLoading.value = false;
  }

  Future<void> searchCourses(String query) async {
    isLoading.value = true;
    var snapshot = await _firestore
        .collection('courses')
        .where('type', isGreaterThanOrEqualTo: query)
        .where('type', isLessThanOrEqualTo: '$query\uf8ff')
        .get();
    var courseList =
        snapshot.docs.map((doc) => Course.fromMap(doc.data(), doc.id)).toList();
    courses.assignAll(courseList);
    isLoading.value = false;
  }

  void addDummyData() async {
    var random = Random();
    var days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    var types = [
      'Flow Yoga',
      'Aerial Yoga',
      'Family Yoga',
      'Power Yoga',
      'Restorative Yoga'
    ];
    var descriptions = [
      'A relaxing flow yoga class.',
      'An exciting aerial yoga class.',
      'A fun family yoga class.',
      'A powerful yoga class.',
      'A restorative yoga class.'
    ];

    var dummyCourses = List.generate(5, (index) {
      return Course(
        id: '',
        day: days[random.nextInt(days.length)],
        time: '${random.nextInt(12) + 1}:00',
        capacity: random.nextInt(30) + 10,
        duration: (random.nextInt(3) + 1) * 30,
        price: (random.nextInt(20) + 5).toDouble(),
        type: types[random.nextInt(types.length)],
        description: descriptions[random.nextInt(descriptions.length)],
      );
    });

    for (var course in dummyCourses) {
      var courseRef =
          await _firestore.collection('courses').add(course.toMap());
      var courseId = courseRef.id;

      // Create random class instances for each course
      for (int i = 0; i < 5; i++) {
        DateTime randomDate = DateTime(
          2023,
          random.nextInt(12) + 1,
          random.nextInt(28) + 1,
          random.nextInt(24),
          random.nextInt(60),
        );
        String randomTeacher = 'Teacher ${random.nextInt(100)}';
        String randomName = 'Class ${random.nextInt(1000)}';

        Class classInstance = Class(
          id: '',
          courseId: courseId,
          date: randomDate.toIso8601String(),
          teacher: randomTeacher,
          name: randomName,
        );
        await _firestore.collection('classes').add(classInstance.toMap());
      }
    }

    fetchCourses(); // Refresh the course list
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../pages/home_page.dart';
import '../models/course_model.dart';
import '../models/class_model.dart';

class CourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var courses = <Course>[].obs;
  var courseClasses = <String, List<Class>>{}.obs;
  var isLoading = false.obs;
  var searchResults = <Course>[].obs;
  var cart = <Course>[].obs;
  var myCourses = <Course>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoursesAndClasses();
  }

  void fetchCoursesAndClasses() async {
    isLoading.value = true;
    var courseSnapshot = await _firestore.collection('courses').get();
    var courseList = courseSnapshot.docs
        .map((doc) => Course.fromMap(doc.data(), doc.id))
        .toList();
    courses.assignAll(courseList);

    for (var course in courseList) {
      var classSnapshot = await _firestore
          .collection('classes')
          .where('courseId', isEqualTo: course.id)
          .get();
      var classList = classSnapshot.docs
          .map((doc) => Class.fromMap(doc.data(), doc.id))
          .toList();
      courseClasses[course.id] = classList;
    }

    isLoading.value = false;
  }

  void searchCourses(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(courses);
    } else {
      var filteredCourses = courses.where((course) {
        var matchesCourse = course.type
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            course.description.toLowerCase().contains(query.toLowerCase()) ||
            course.day.toLowerCase().contains(query.toLowerCase()) ||
            course.time.toLowerCase().contains(query.toLowerCase());
        var matchesClass = courseClasses[course.id]?.any((classInstance) {
              return classInstance.teacher
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  classInstance.date
                      .toLowerCase()
                      .contains(query.toLowerCase());
            }) ??
            false;
        return matchesCourse || matchesClass;
      }).toList();
      searchResults.assignAll(filteredCourses);
    }
  }

  void addToCart(Course course) {
    if (!cart.contains(course)) {
      cart.add(course);
      Get.snackbar(
        'Course Added',
        '${course.description} has been added to your cart.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void removeFromCart(Course course) {
    cart.remove(course);
    Get.snackbar(
      'Course Removed',
      '${course.description} has been removed from your cart.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  Future<void> confirmBooking({
    required String name,
    required String email,
    required String phone,
  }) async {
    await _firestore.collection('users').add({
      'name': name,
      'email': email,
      'phone': phone,
      'courses': cart.map((course) => course.id).toList(),
    });

    Get.snackbar(
      'Success',
      'Booking confirmed!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    myCourses.addAll(cart);
    cart.clear();
    Get.offAll(() => const HomePage());
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

    fetchCoursesAndClasses(); // Refresh the course and class list
  }
}

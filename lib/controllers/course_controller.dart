import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/class_model.dart';
import '../models/course_model.dart';
import '../pages/home_page.dart';

// Controller for managing courses and classes in the Universal Yoga Customer App.
class CourseController extends GetxController {
  // Instance of Firestore to interact with the database.
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list of courses.
  var courses = <Course>[].obs;

  // Observable map of course IDs to their respective list of classes.
  var courseClasses = <String, List<Class>>{}.obs;

  // Observable boolean to track loading state.
  var isLoading = false.obs;

  // Observable list of search results.
  var searchResults = <Course>[].obs;

  // Observable list of courses added to the cart.
  var cart = <Course>[].obs;

  // Observable list of courses booked by the user.
  var myCourses = <Course>[].obs;

  // Called when the controller is initialized.
  @override
  void onInit() {
    super.onInit();
    fetchCoursesAndClasses();
  }

  // Fetches courses and their respective classes from Firestore.
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

  // Searches for courses and classes that match the given query.
  //
  // [query] The search query string.
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

  // Adds a course to the cart and shows a snackbar notification.
  //
  // [course] The course to be added to the cart.
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

  // Removes a course from the cart and shows a snackbar notification.
  //
  // [course] The course to be removed from the cart.
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

  // Confirms the booking of courses in the cart and saves user information to Firestore.
  //
  // [name] The name of the user.
  // [email] The email of the user.
  // [phone] The phone number of the user.
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

  // Adds dummy data for testing purposes.
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

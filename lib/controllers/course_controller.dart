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
      var classList = course.itemList;
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
        var matchesCourse = course.classType
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            course.courseName.toLowerCase().contains(query.toLowerCase()) ||
            course.description.toLowerCase().contains(query.toLowerCase()) ||
            course.dayOfWeek.toLowerCase().contains(query.toLowerCase()) ||
            course.timeOfDay.toLowerCase().contains(query.toLowerCase());
        var matchesClass = courseClasses[course.id]?.any((classInstance) {
              return classInstance.className
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  classInstance.teacherName
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
        '${course.courseName} has been added to your cart.',
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
      '${course.courseName} has been removed from your cart.',
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
    for (var course in cart) {
      await _firestore.collection('courses').doc(course.id).update({
        'users': FieldValue.arrayUnion([
          {
            'name': name,
            'email': email,
            'phone': phone,
          }
        ])
      });
    }

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
    var names = [
      'Sunrise Yoga',
      'Evening Relaxation',
      'Weekend Warrior',
      'Midday Stretch',
      'Zen Flow'
    ];
    var descriptions = [
      'A relaxing flow yoga class.',
      'An exciting aerial yoga class.',
      'A fun family yoga class.',
      'A powerful yoga class.',
      'A restorative yoga class.'
    ];

    DateTime randomDate = DateTime(
      2023,
      random.nextInt(12) + 1,
      random.nextInt(28) + 1,
      random.nextInt(24),
      random.nextInt(60),
    );
    var dummyCourses = List.generate(5, (index) {
      var classList = List.generate(3, (classIndex) {
        return Class(
          classId: classIndex,
          className: 'Class ${classIndex + 1}',
          date: randomDate.toIso8601String(),
          image: 'null',
          teacherName: 'Teacher ${random.nextInt(100)}',
          timestamp: randomDate.millisecondsSinceEpoch,
        );
      });

      return Course(
        id: '0',
        courseId: 0,
        dayOfWeek: days[random.nextInt(days.length)],
        timeOfDay: '${random.nextInt(12) + 1}:00',
        capacity: random.nextInt(30) + 10,
        duration: ((random.nextInt(3) + 1) * 30).toString(),
        pricing: (random.nextInt(20) + 5).toDouble(),
        classType: types[random.nextInt(types.length)],
        description: descriptions[random.nextInt(descriptions.length)],
        courseName: names[random.nextInt(names.length)],
        itemList: classList,
        timestamp: randomDate.millisecondsSinceEpoch,
      );
    });

    for (var course in dummyCourses) {
      await _firestore.collection('courses').add(course.toMap());
    }

    fetchCoursesAndClasses(); // Refresh the course and class list
  }
}

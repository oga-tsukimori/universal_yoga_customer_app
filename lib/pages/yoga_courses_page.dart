import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/course_card.dart';
import '../controllers/course_controller.dart';

// A stateless widget that displays a list of yoga courses.
//
// This widget uses the `CourseController` to fetch and display a list of yoga courses.
// It shows a loading indicator while the data is being fetched, and displays a message
// if no courses are available. Once the data is fetched, it displays the courses in a
// `ListView` using the `CourseCard` widget for each course.
class YogaCoursesPage extends StatelessWidget {
  // The controller responsible for managing the state of the courses.
  final CourseController courseController = Get.find();

  // Creates a new instance of `YogaCoursesPage`.
  YogaCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show a loading indicator while the courses are being fetched.
      if (courseController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      // Show a message if no courses are available.
      if (courseController.courses.isEmpty) {
        return const Center(child: Text('No courses available.'));
      }
      // Display the list of courses using a ListView.
      return ListView.builder(
        itemCount: courseController.courses.length,
        itemBuilder: (context, index) {
          var course = courseController.courses[index];
          var courseClasses = courseController.courseClasses[course.id] ?? [];
          return CourseCard(course: course, courseClasses: courseClasses);
        },
      );
    });
  }
}

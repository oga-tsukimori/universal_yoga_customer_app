import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/course_card.dart';
import '../controllers/course_controller.dart';

// A stateless widget that displays the user's courses.
//
// This widget uses the `CourseController` to fetch and display the user's courses.
// If the user has no courses, a message is displayed indicating that there are no courses.
// Otherwise, a list of `CourseCard` widgets is displayed, each representing a course.
//
// The `CourseCard` widget is used to display individual courses along with their classes.

class MyCoursesPage extends StatelessWidget {
  final CourseController courseController = Get.find();

  MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (courseController.myCourses.isEmpty) {
        return const Center(child: Text('You have no courses.'));
      }
      return ListView.builder(
        itemCount: courseController.myCourses.length,
        itemBuilder: (context, index) {
          var course = courseController.myCourses[index];
          var courseClasses = courseController.courseClasses[course.id] ?? [];
          return CourseCard(course: course, courseClasses: courseClasses);
        },
      );
    });
  }
}

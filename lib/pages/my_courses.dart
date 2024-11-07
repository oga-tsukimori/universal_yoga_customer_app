import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/course_card.dart';
import '../controllers/course_controller.dart';

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

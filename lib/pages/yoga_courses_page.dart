import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/course_card.dart';
import '../controllers/course_controller.dart';

class YogaCoursesPage extends StatelessWidget {
  final CourseController courseController = Get.find();

  YogaCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (courseController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (courseController.courses.isEmpty) {
        return const Center(child: Text('No courses available.'));
      }
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

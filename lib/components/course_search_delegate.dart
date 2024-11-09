import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/course_controller.dart';
import 'course_card.dart';

class CourseSearchDelegate extends SearchDelegate {
  final CourseController courseController = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          courseController.searchResults.clear();
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    courseController.searchCourses(query);
    if (courseController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (courseController.searchResults.isEmpty) {
      return const Center(child: Text('No courses found.'));
    }
    return ListView.builder(
      itemCount: courseController.searchResults.length,
      itemBuilder: (context, index) {
        var course = courseController.searchResults[index];
        var courseClasses = courseController.courseClasses[course.id] ?? [];
        return CourseCard(course: course, courseClasses: courseClasses);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Search for courses'));
    }
    courseController.searchCourses(query);
    if (courseController.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (courseController.searchResults.isEmpty) {
      return const Center(child: Text('No courses found.'));
    }
    return ListView.builder(
      itemCount: courseController.searchResults.length,
      itemBuilder: (context, index) {
        var course = courseController.searchResults[index];
        var courseClasses = courseController.courseClasses[course.id] ?? [];
        return CourseCard(course: course, courseClasses: courseClasses);
      },
    );
  }
}

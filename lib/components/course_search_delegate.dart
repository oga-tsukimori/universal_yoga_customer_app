import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/course_controller.dart';
import 'course_card.dart';

// A custom search delegate for searching courses.
//
// This class extends [SearchDelegate] and provides the UI and logic for
// searching courses using a [CourseController].
//
// The search delegate includes actions for clearing the search query,
// a leading icon for closing the search, and displays search results
// or suggestions based on the user's input.
//
// The [CourseController] is used to manage the search results and loading state.

class CourseSearchDelegate extends SearchDelegate {
  // The controller responsible for managing course data and search results.
  final CourseController courseController = Get.find();

  // Builds the actions for the search bar.
  //
  // This includes a clear button to clear the search query and search results.
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

  // Builds the leading icon for the search bar.
  //
  // This includes a back button to close the search.
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // Builds the results based on the search query.
  //
  // This method triggers a search using the [CourseController] and displays
  // a loading indicator, a message if no courses are found, or a list of
  // search results.
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

  // Builds the suggestions based on the search query.
  //
  // This method triggers a search using the [CourseController] and displays
  // a loading indicator, a message if no courses are found, or a list of
  // search suggestions.
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

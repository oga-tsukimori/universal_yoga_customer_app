// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_yoga_customer_app/models/class_model.dart';
import 'package:universal_yoga_customer_app/models/course_model.dart';
import '../controllers/course_controller.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  final CourseController courseController = Get.find();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CourseSearchDelegate());
            },
          ),
        ],
      ),
      body: Obx(() {
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
            if (!courseController.courseClasses.containsKey(course.id)) {
              courseController.fetchClasses(course.id);
            }
            var courseClasses = courseController.courseClasses[course.id] ?? [];
            return CourseCard(course: course, courseClasses: courseClasses);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          courseController.addDummyData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.courseClasses,
  });

  final Course course;
  final List<Class> courseClasses;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              course.description,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (courseClasses.isNotEmpty) ...[
              Text(
                'From: ${courseClasses.first.date.split('T').first} - To: ${courseClasses.last.date.split('T').first} (${course.duration} minutes)',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              ...courseClasses.map((classInstance) {
                return SizedBox(
                  width: double.infinity,
                  child: ClassCard(classInstance: classInstance),
                );
              }),
              const SizedBox(height: 10),
              Text(
                'Special Sales... \$${course.price} Only per member!',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Add to Cart functionality
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue,
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('Add to Cart'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Book Now functionality
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            ] else ...[
              const Center(child: Text('No classes available')),
            ],
          ],
        ),
      ),
    );
  }
}

class ClassCard extends StatelessWidget {
  final Class classInstance;
  const ClassCard({
    super.key,
    required this.classInstance,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classInstance.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tr. ${classInstance.teacher}'),
                Row(
                  children: [
                    Text(classInstance.date.split('T').first),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat.jm().format(
                        DateTime.parse(classInstance.date),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CourseSearchDelegate extends SearchDelegate {
  final CourseController courseController = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
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
    return FutureBuilder(
      future: courseController.searchCourses(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(() {
            if (courseController.courses.isEmpty) {
              return const Center(child: Text('No courses found.'));
            }
            return ListView.builder(
              itemCount: courseController.courses.length,
              itemBuilder: (context, index) {
                var course = courseController.courses[index];
                if (!courseController.courseClasses.containsKey(course.id)) {
                  courseController.fetchClasses(course.id);
                }
                var courseClasses =
                    courseController.courseClasses[course.id] ?? [];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.description,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        if (courseClasses.isNotEmpty) ...[
                          Text(
                            'From: ${courseClasses.first.date.split('T').first} - To: ${courseClasses.last.date.split('T').first} (${course.duration} minutes)',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          ...courseClasses.map((classInstance) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Class: ${classInstance.name}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Teacher: ${classInstance.teacher}'),
                                    Text(
                                        'Date: ${classInstance.date.split('T').first}'),
                                    Text(
                                        'Time: ${classInstance.date.split('T').last.split('.').first}'),
                                  ],
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 10),
                          Text(
                            'Special Sales... \$${course.price} Only per member!',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Add to Cart functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text('Add to Cart'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Book Now functionality
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text('Book Now'),
                              ),
                            ],
                          ),
                        ] else ...[
                          const Center(child: Text('No classes available')),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          });
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

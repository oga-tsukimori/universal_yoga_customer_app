// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/course_card.dart';
import '../components/course_search_delegate.dart';
import '../controllers/course_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CourseController courseController = Get.find();
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    YogaCoursesPage(),
    CartPage(),
    YourCoursesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Yoga Courses'
              : _selectedIndex == 1
                  ? 'Your Cart'
                  : 'Your Courses',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
        actions: _selectedIndex == 0
            ? [
                Obx(() {
                  return IconButton(
                    icon: Icon(
                      Icons.search,
                      color: courseController.isLoading.value
                          ? Colors.grey
                          : Colors.white,
                    ),
                    onPressed: courseController.isLoading.value
                        ? null
                        : () {
                            showSearch(
                                context: context,
                                delegate: CourseSearchDelegate());
                          },
                  );
                }),
              ]
            : null,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Yoga Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Your Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Your Courses',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
    );
  }
}

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

class CartPage extends StatelessWidget {
  final CourseController courseController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (courseController.cart.isEmpty) {
        return const Center(child: Text('Your cart is empty.'));
      }
      return ListView.builder(
        itemCount: courseController.cart.length,
        itemBuilder: (context, index) {
          var course = courseController.cart[index];
          var courseClasses = courseController.courseClasses[course.id] ?? [];
          return CourseCard(
            course: course,
            courseClasses: courseClasses,
            isInCart: true,
          );
        },
      );
    });
  }
}

class YourCoursesPage extends StatelessWidget {
  final CourseController courseController = Get.find();

  YourCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (courseController.yourCourses.isEmpty) {
        return const Center(child: Text('You have no courses.'));
      }
      return ListView.builder(
        itemCount: courseController.yourCourses.length,
        itemBuilder: (context, index) {
          var course = courseController.yourCourses[index];
          var courseClasses = courseController.courseClasses[course.id] ?? [];
          return CourseCard(course: course, courseClasses: courseClasses);
        },
      );
    });
  }
}

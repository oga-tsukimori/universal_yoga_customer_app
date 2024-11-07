// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/course_search_delegate.dart';
import '../controllers/course_controller.dart';
import '../pages/cart_page.dart';
import '../pages/my_courses.dart';
import '../pages/yoga_courses_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final CourseController courseController = Get.find();
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    YogaCoursesPage(),
    CartPage(),
    MyCoursesPage(),
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
          actions: [
            IconButton(
              icon: Stack(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  Positioned(
                    right: 0,
                    child: Obx(() {
                      return CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${courseController.cart.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = 1; // Navigate to the cart page
                });
              },
            ),
            _selectedIndex == 0
                ? Obx(() {
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
                  })
                : Container(),
          ]),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Yoga Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Courses',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     courseController.addDummyData();
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

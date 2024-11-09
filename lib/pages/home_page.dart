import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/course_search_delegate.dart';
import '../controllers/course_controller.dart';
import 'cart_page.dart';
import 'my_courses_page.dart';
import 'yoga_courses_page.dart';

// HomePage is a StatefulWidget that represents the main screen of the app.
// It contains a bottom navigation bar to switch between different pages:
// YogaCoursesPage, CartPage, and MyCoursesPage.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // CourseController instance to manage the state of courses and cart.
  final CourseController courseController = Get.find();

  // Index of the currently selected bottom navigation bar item.
  int _selectedIndex = 0;

  // List of pages to display based on the selected bottom navigation bar item.
  static final List<Widget> _pages = <Widget>[
    YogaCoursesPage(),
    CartPage(),
    MyCoursesPage(),
  ];

  // Updates the selected index and refreshes the UI.
  //
  // [index] is the index of the selected bottom navigation bar item.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Title of the AppBar changes based on the selected page.
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
          // Shopping cart icon with a badge showing the number of items in the cart.
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

          // Search icon that opens a search delegate when tapped.
          // Only visible on the YogaCoursesPage.
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
        ],
      ),

      // Body of the Scaffold displays the selected page.
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
      // Uncomment the following lines to add a floating action button for adding dummy data.
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     courseController.addDummyData();
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

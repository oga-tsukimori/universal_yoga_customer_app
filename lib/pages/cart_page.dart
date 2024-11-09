import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/course_card.dart';
import '../controllers/course_controller.dart';

// A stateless widget that represents the cart page in the application.
//
// This page displays the courses that have been added to the cart. If the cart
// is empty, a message indicating that the cart is empty is shown. Otherwise,
// a list of `CourseCard` widgets is displayed, each representing a course in
// the cart.
//
// The `CartPage` uses the `CourseController` to manage the state of the cart
// and the courses.
//
// The `Obx` widget is used to reactively rebuild the UI whenever the state of
// the cart changes.

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

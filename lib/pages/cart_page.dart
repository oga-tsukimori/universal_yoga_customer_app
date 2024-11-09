import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/course_card.dart';
import '../controllers/course_controller.dart';

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

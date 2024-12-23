import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import '../models/class_model.dart';
import '../models/course_model.dart';
import '../pages/booking_page.dart';
import 'class_card.dart';

// A widget that displays a card containing information about a course and its associated classes.
//
// The [CourseCard] widget is a stateless widget that takes in a [Course] object, a list of [Class] objects,
// and a boolean indicating whether the course is in the cart. It displays the course description,
// schedule, duration, price, and a list of class cards. It also provides buttons to add/remove the
// course from the cart and to navigate to the booking page.
//
// The widget uses the GetX package for state management and navigation.
//
// Parameters:
// - [course]: The [Course] object containing information about the course.
// - [courseClasses]: A list of [Class] objects associated with the course.
// - [isInCart]: A boolean indicating whether the course is in the cart. Defaults to false.
//
// Example usage:
// ```dart
// CourseCard(
//   course: myCourse,
//   courseClasses: myCourseClasses,
//   isInCart: true,
// )
// ```

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.courseClasses,
    this.isInCart = false,
  });

  final Course course;
  final List<Class> courseClasses;
  final bool isInCart;

  @override
  Widget build(BuildContext context) {
    final CourseController courseController = Get.find();

    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.pink[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              course.courseName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              course.description,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 10),
            if (courseClasses.isNotEmpty) ...[
              Text(
                'Every ${course.dayOfWeek}!',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${courseClasses.first.date.split('T').first} - ${courseClasses.last.date.split('T').first} (${course.duration} minutes)',
                style: const TextStyle(fontSize: 16, color: Colors.pink),
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
                'Special Sales... \$${course.pricing} Only per member!',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                final bool isCourseInCart =
                    courseController.cart.contains(course);
                final bool isCourseBooked =
                    courseController.myCourses.contains(course);
                if (isCourseBooked) {
                  return const SizedBox.shrink();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        (!isInCart && !isCourseInCart)
                            ? courseController.addToCart(course)
                            : courseController.removeFromCart(course);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.pink,
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        (!isInCart && !isCourseInCart)
                            ? 'Add to Cart'
                            : 'Remove from Cart',
                      ),
                    ),
                    if (isInCart || isCourseInCart)
                      Padding(
                        padding: const EdgeInsets.only(left: 28),
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => BookingPage());
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.pink,
                          ),
                          child: const Text('Book Now'),
                        ),
                      ),
                  ],
                );
              }),
            ] else ...[
              const Center(
                child: Text(
                  'No classes available',
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

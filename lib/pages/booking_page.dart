import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class BookingPage extends StatelessWidget {
  // Initialize the CourseController using GetX
  final CourseController courseController = Get.find();

  // Controllers for the text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(), // Navigate back
        ),
        title: const Text(
          'Booking Confirmation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Courses in Cart:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 10),
            // Display the list of courses in the cart
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: courseController.cart.length,
                  itemBuilder: (context, index) {
                    var course = courseController.cart[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Colors.pink[50],
                      child: ListTile(
                        title: Text(
                          course.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.description,
                              style: const TextStyle(color: Colors.pink),
                            ),
                            Text(
                              'Date: ${course.day}',
                              style: const TextStyle(color: Colors.pink),
                            ),
                            Text(
                              'Price: \$${course.price}',
                              style: const TextStyle(color: Colors.pink),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            // Display the total cost of the courses in the cart
            Obx(() {
              double totalCost = courseController.cart
                  .fold(0, (sum, course) => sum + course.price);
              return Text(
                'Total Cost: \$${totalCost.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              );
            }),
            const SizedBox(height: 20),
            // Text field for name input
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.pink),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
            // Text field for email input
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.pink),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
            // Text field for phone input
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                labelStyle: TextStyle(color: Colors.pink),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Button to confirm the booking
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Check if all fields are filled
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      phoneController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please fill in all fields',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  try {
                    // Attempt to confirm the booking
                    await courseController.confirmBooking(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneController.text,
                    );
                  } catch (e) {
                    // Show error message if booking fails
                    Get.snackbar(
                      'Error',
                      'Failed to confirm booking',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pink,
                ),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

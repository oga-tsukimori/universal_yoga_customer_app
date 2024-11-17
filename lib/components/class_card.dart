import 'package:flutter/material.dart';

import '../models/class_model.dart';

// A stateless widget that represents a card displaying information about a class.
//
// The [ClassCard] widget takes a [Class] instance and displays its name, teacher,
// and date in a styled card format. The card has a pink theme and includes padding
// and margin for better spacing.
//
// The [classInstance] parameter is required and should be an instance of the [Class] model.
//
// Example usage:
// ```dart
// ClassCard(
//   classInstance: myClassInstance,
// )
// ```
//
// The widget displays:
// - The class name in bold.
// - The teacher's name prefixed with "Tr.".
// - The date and time of the class.

// A stateless widget that represents a card displaying information about a class.
//
// The [ClassCard] widget takes a [Class] instance and displays its name, teacher,
// and date in a styled card format. The card has a pink theme and includes padding
// and margin for better spacing.
//
// The [classInstance] parameter is required and should be an instance of the [Class] model.
//
// Example usage:
// ```dart
// ClassCard(
//   classInstance: myClassInstance,
// )
// ```
//
// The widget displays:
// - The class name in bold.
// - The teacher's name prefixed with "Tr.".
// - The date and time of the class.

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
      color: Colors.pink[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classInstance.className,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tr. ${classInstance.teacherName}',
                  style: const TextStyle(color: Colors.pink),
                ),
                Text(
                  classInstance.date,
                  style: const TextStyle(color: Colors.pink),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

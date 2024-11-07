import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/class_model.dart';

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
              classInstance.name,
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
                  'Tr. ${classInstance.teacher}',
                  style: const TextStyle(color: Colors.pink),
                ),
                Row(
                  children: [
                    Text(
                      classInstance.date.split('T').first,
                      style: const TextStyle(color: Colors.pink),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat.jm().format(
                        DateTime.parse(classInstance.date),
                      ),
                      style: const TextStyle(color: Colors.pink),
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

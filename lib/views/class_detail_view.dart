// views/class_detail_view.dart
import 'package:flutter/material.dart';
import '../models/class_model.dart';

class ClassDetailView extends StatelessWidget {
  final YogaClass yogaClass;

  const ClassDetailView({super.key, required this.yogaClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(yogaClass.type),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Day: ${yogaClass.day}', style: const TextStyle(fontSize: 18)),
            Text('Time: ${yogaClass.time}',
                style: const TextStyle(fontSize: 18)),
            Text('Capacity: ${yogaClass.capacity}',
                style: const TextStyle(fontSize: 18)),
            Text('Duration: ${yogaClass.duration} minutes',
                style: const TextStyle(fontSize: 18)),
            Text('Price: £${yogaClass.price}',
                style: const TextStyle(fontSize: 18)),
            Text('Description: ${yogaClass.description}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

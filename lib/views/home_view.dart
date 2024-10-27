// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/class_controller.dart';
import 'class_detail_view.dart';

class HomeView extends StatelessWidget {
  final ClassController classController = Get.find();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Classes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ClassSearchDelegate());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (classController.classes.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: classController.classes.length,
          itemBuilder: (context, index) {
            var yogaClass = classController.classes[index];
            return ListTile(
              title: Text(yogaClass.type),
              subtitle: Text('${yogaClass.day} at ${yogaClass.time}'),
              onTap: () {
                Get.to(() => ClassDetailView(yogaClass: yogaClass));
              },
            );
          },
        );
      }),
    );
  }
}

class ClassSearchDelegate extends SearchDelegate {
  final ClassController classController = Get.find();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    classController.searchClasses(query);
    return Obx(() {
      if (classController.classes.isEmpty) {
        return const Center(child: Text('No classes found.'));
      }
      return ListView.builder(
        itemCount: classController.classes.length,
        itemBuilder: (context, index) {
          var yogaClass = classController.classes[index];
          return ListTile(
            title: Text(yogaClass.type),
            subtitle: Text('${yogaClass.day} at ${yogaClass.time}'),
            onTap: () {
              Get.to(() => ClassDetailView(yogaClass: yogaClass));
            },
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

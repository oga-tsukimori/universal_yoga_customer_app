import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'utils/dependency_injection.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';

// The main function is the entry point of the application.
void main() async {
  // Ensures that widget binding is initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection.
  DependencyInjection.init();

  // Initialize Firebase with the default options for the current platform.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the Flutter application.
  runApp(const MyApp());
}

// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // GetMaterialApp is a wrapper for MaterialApp with additional features from the GetX package.
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner.
      home: HomePage(), // Set HomePage as the initial route.
    );
  }
}

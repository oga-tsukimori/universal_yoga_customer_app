import 'package:get/get.dart';

import '../controllers/course_controller.dart';

// A class responsible for initializing dependencies for the application.
//
// This class uses the GetX package to lazily initialize and inject dependencies
// when they are needed. This helps in managing the lifecycle and dependencies
// of various controllers and services in the application.
class DependencyInjection {
  // Initializes the dependencies required for the application.
  //
  // This method uses `Get.lazyPut` to register the `CourseController` so that
  // it is created only when it is first used. This helps in optimizing the
  // resource usage and ensures that the controller is available when needed.
  static void init() {
    Get.lazyPut(() => CourseController());
  }
}

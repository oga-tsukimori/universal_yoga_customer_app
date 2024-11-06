import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut(() => CourseController());
  }
}

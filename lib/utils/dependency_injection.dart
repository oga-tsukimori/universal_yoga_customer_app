import 'package:get/get.dart';
import '../controllers/class_controller.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut(() => ClassController());
  }
}

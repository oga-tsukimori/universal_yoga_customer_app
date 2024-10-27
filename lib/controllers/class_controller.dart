// controllers/class_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/class_model.dart';

class ClassController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var classes = <YogaClass>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchClasses();
  }

  void fetchClasses() async {
    var snapshot = await _firestore.collection('classes').get();
    var classList = snapshot.docs
        .map((doc) => YogaClass.fromMap(doc.data(), doc.id))
        .toList();
    classes.assignAll(classList);
  }

  void searchClasses(String query) {
    var filteredClasses = classes
        .where((c) => c.day.contains(query) || c.time.contains(query))
        .toList();
    classes.assignAll(filteredClasses);
  }
}

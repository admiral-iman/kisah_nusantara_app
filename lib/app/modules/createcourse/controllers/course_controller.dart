import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var courseName = ''.obs;
  var courseDescription = ''.obs;
  var isLoading = false.obs;

  // Function to add course to Firestore
  Future<void> addCourse() async {
    if (courseName.isEmpty || courseDescription.isEmpty) {
      Get.snackbar('Validation Error', 'Name and Description cannot be empty');
      return;
    }

    isLoading(true);
    try {
      await _firestore.collection('courses').add({
        'name': courseName.value,
        'description': courseDescription.value,
        'createdAt': DateTime.now(),
      });
      // Clear fields after adding
      courseName.value = '';
      courseDescription.value = '';
      Get.snackbar('Success', 'Course created successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create course: $e');
    } finally {
      isLoading(false);
    }
  }
}

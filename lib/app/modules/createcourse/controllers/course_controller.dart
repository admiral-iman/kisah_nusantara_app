import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseController extends GetxController {
  var courses = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  var courseName = ''.obs;
  var courseDescription = ''.obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  Future<void> fetchCourses() async {
    isLoading(true);
    try {
      var result = await firestore.collection('courses').get();
      courses.value =
          result.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addCourse() async {
    await firestore.collection('courses').add({
      'name': courseName.value,
      'description': courseDescription.value,
    });
    fetchCourses();
  }

  Future<void> updateCourse(String id) async {
    await firestore.collection('courses').doc(id).update({
      'name': courseName.value,
      'description': courseDescription.value,
    });
    fetchCourses();
  }

  Future<void> deleteCourse(String id) async {
    await firestore.collection('courses').doc(id).delete();
    fetchCourses();
  }
}

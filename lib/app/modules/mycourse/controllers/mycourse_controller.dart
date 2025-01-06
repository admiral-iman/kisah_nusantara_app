import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MyCourseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list untuk menyimpan data kursus dari Firestore
  var courses = <Map<String, dynamic>>[].obs;

  // List untuk menyimpan ID kursus yang dipilih
  var selectedCourses = <String>[].obs;

  // Mengambil data kursus dari Firestore
  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  void fetchCourses() {
    _firestore.collection('courses').snapshots().listen((snapshot) {
      courses.value = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'name': doc['name'],
          'description': doc['description'],
          'selected': selectedCourses.contains(doc.id),
        };
      }).toList();
    });
  }

  void editCourse(String courseId) {
    toggleCourse(courseId);
    Get.toNamed('/mycourse');
  }

  // Menambahkan atau menghapus kursus dari keranjang
  void toggleCourse(String id) {
    if (selectedCourses.contains(id)) {
      selectedCourses.remove(id);
    } else {
      selectedCourses.add(id);
    }
    updateCourseSelection();
  }

  // Update status selected pada setiap kursus
  void updateCourseSelection() {
    courses.value = courses.map((course) {
      return {
        ...course,
        'selected': selectedCourses.contains(course['id']),
      };
    }).toList();
  }

  // Mendapatkan total kursus yang dipilih
  int get selectedCount => selectedCourses.length;
}

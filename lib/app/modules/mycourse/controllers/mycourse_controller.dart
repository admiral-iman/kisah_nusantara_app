import 'package:get/get.dart';

class MyCourseController extends GetxController {
  // Observable list of courses
  var courses = <Map<String, dynamic>>[
    {'id': 1, 'name': 'Sejarah Nusantara', 'selected': false},
    {'id': 2, 'name': 'Bahasa Daerah', 'selected': false},
    {'id': 3, 'name': 'Budaya Lokal', 'selected': false},
    {'id': 4, 'name': 'Kerajaan Hindu-Buddha', 'selected': false},
    {'id': 5, 'name': 'Kerajaan Islam', 'selected': false},
  ].obs;

  // Observable variable to track selected courses count
  var selectedCount = 0.obs;

  // Function to toggle selection of a course
  void toggleCourse(int id) {
    final index = courses.indexWhere((course) => course['id'] == id);
    if (index != -1) {
      courses[index]['selected'] = !courses[index]['selected'];
      updateSelectedCount();
    }
  }

  // Update the count of selected courses
  void updateSelectedCount() {
    selectedCount.value =
        courses.where((course) => course['selected'] == true).length;
  }
}

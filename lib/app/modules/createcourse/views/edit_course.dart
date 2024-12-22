import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class EditCoursePage extends StatelessWidget {
  final String courseId;
  final CourseController controller = Get.find();

  EditCoursePage({required this.courseId});

  @override
  Widget build(BuildContext context) {
    final course = controller.courses.firstWhere((c) => c['id'] == courseId);
    controller.courseName.value = course['name'];
    controller.courseDescription.value = course['description'];

    return Scaffold(
      appBar: AppBar(title: Text('Edit Kelas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.courseName.value = value,
              decoration: InputDecoration(labelText: 'Nama Kelas'),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => controller.courseDescription.value = value,
              decoration: InputDecoration(labelText: 'Deskripsi'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.updateCourse(courseId);
                Get.back();
              },
              child: Text('Update'),
            )
          ],
        ),
      ),
    );
  }
}

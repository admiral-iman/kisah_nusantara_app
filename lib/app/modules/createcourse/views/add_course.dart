import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class AddCoursePage extends StatelessWidget {
  final CourseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Kelas Baru')),
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
                await controller.addCourse();
                Get.back();
              },
              child: Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}

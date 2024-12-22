import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/mycourse/controllers/mycourse_controller.dart';

class MyCoursePage extends StatelessWidget {
  final MyCourseController controller = Get.put(MyCourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kelas Anda'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.courses.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.courses.length,
                itemBuilder: (context, index) {
                  final course = controller.courses[index];
                  return Card(
                    child: ListTile(
                      title: Text(course['name']),
                      subtitle: Text(course['description']),
                      trailing: Icon(
                        course['selected']
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: course['selected'] ? Colors.green : Colors.grey,
                      ),
                      onTap: () {
                        controller.toggleCourse(course['id']);
                      },
                    ),
                  );
                },
              );
            }),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total kelas dipilih: ${controller.selectedCount}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }),
        ],
      ),
    );
  }
}

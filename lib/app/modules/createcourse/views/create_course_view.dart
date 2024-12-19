import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class CreateCourseView extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  controller.courseName.value = value;
                },
                decoration: InputDecoration(
                  labelText: 'Course Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  controller.courseDescription.value = value;
                },
                decoration: InputDecoration(
                  labelText: 'Course Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        controller.addCourse();
                      },
                      child: Text('Create Course'),
                    ),
            ],
          );
        }),
      ),
    );
  }
}

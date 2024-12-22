import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';
import 'add_course.dart';
import 'edit_course.dart';
import 'course_card.dart';

class CreateCourseView extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Kelas'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.courses.length,
          itemBuilder: (context, index) {
            final course = controller.courses[index];
            return CourseCard(
              course: course,
              onEdit: () {
                Get.to(() => EditCoursePage(courseId: course['id']));
              },
              onDelete: () {
                controller.deleteCourse(course['id']);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddCoursePage());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

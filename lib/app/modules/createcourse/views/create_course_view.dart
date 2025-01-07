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
        backgroundColor: Color(0xFFDFD0B8), // Primary color for AppBar
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.courses.length,
          itemBuilder: (context, index) {
            final course = controller.courses[index];
            return Card(
              color: Color(0xFF3C5B6F), // Tertiary color for Card background
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  course['name'],
                  style: TextStyle(
                    color: Colors.white, // White text on card
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  course['description'],
                  style: TextStyle(
                    color: Colors.white70, // Lighter text for description
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit,
                          color: Color(0xFFDFD0B8)), // Edit icon color
                      onPressed: () {
                        Get.to(() => EditCoursePage(courseId: course['id']));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete,
                          color: Color(0xFFDFD0B8)), // Delete icon color
                      onPressed: () {
                        controller.deleteCourse(course['id']);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddCoursePage());
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFFDFD0B8), // Secondary color for FAB
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255), // Background color
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/course_controller.dart';

class AddCoursePage extends StatelessWidget {
  final CourseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Kelas Baru'),
        backgroundColor: Color(0xFFDFD0B8), // Primary color for AppBar
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20.0), // Increased padding for cleaner layout
        child: SingleChildScrollView(
          // Added scrolling for smaller screens
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align items to the left
            children: [
              // Name field
              Text(
                'Nama Kelas',
                style: TextStyle(
                  color: Color(0xFF153448), // Primary color for label
                  fontSize: 18, // Improved font size for readability
                  fontWeight: FontWeight.bold, // Bold for emphasis
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) => controller.courseName.value = value,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  filled: true,
                  fillColor: Colors.white, // White background for text input
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Color(0xFF3C5B6F)), // Secondary color for border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Color(0xFF3C5B6F)), // Secondary color on focus
                  ),
                  hintText: 'Masukkan nama kelas',
                ),
              ),
              SizedBox(height: 20),

              // Description field
              Text(
                'Deskripsi Kelas',
                style: TextStyle(
                  color: Color(0xFF153448), // Primary color for label
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (value) =>
                    controller.courseDescription.value = value,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF3C5B6F)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFF3C5B6F)),
                  ),
                  hintText: 'Masukkan deskripsi kelas',
                ),
                maxLines: 4,
              ),
              SizedBox(height: 30),

              // Save button
              ElevatedButton(
                onPressed: () async {
                  await controller.addCourse();
                  Get.back();
                },
                child: Text('Simpan', style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF3C5B6F), // Secondary color for button
                  onPrimary: Colors.white, // White text on button
                  padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 40), // Increased padding for button
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Rounded button corners
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 254, 254, 254), // Background color
    );
  }
}

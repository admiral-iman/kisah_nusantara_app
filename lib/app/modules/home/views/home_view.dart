import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/course/bahasa/views/bahasa_page.dart';
import 'package:kisah_nusantara_app/app/modules/course/budaya/views/budaya_page.dart';
import 'package:kisah_nusantara_app/app/modules/course/sejarah/views/sejarah_page.dart';
import 'package:kisah_nusantara_app/app/modules/createcourse/views/create_course_view.dart';

import '../../profile/controllers/auth_controller.dart';
import '../../profile/views/profile_view.dart';
import 'bottom_navbar.dart';

class HomeView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  // Widget untuk kartu kursus
  Widget _buildCourseCard(
      String title, String description, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF153448), // Primary Color
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.arrow_forward, color: Color(0xFF153448)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      Obx(() => Text(
                            authController.userName.value.isEmpty
                                ? 'User'
                                : authController.userName.value,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF153448),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        child:
                            Icon(Icons.notifications, color: Color(0xFF153448)),
                      ),
                      SizedBox(width: 8),
                      Obx(() {
                        // Tampilkan tombol admin jika isAdmin == true
                        if (authController.isAdmin.value) {
                          return ElevatedButton(
                            onPressed: () {
                              Get.to(() =>
                                  CreateCourseView()); // Arahkan ke halaman createcourse
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF153448),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text('Create Course'),
                          );
                        } else {
                          return SizedBox.shrink(); // Jangan tampilkan apa pun
                        }
                      }),
                    ],
                  ),
                ],
              ),

              // Kartu Pengingat
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFDFD0B8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.history_edu, color: Color(0xFF3C5B6F), size: 40),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kelas Sejarah Kerajaan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF153448),
                            ),
                          ),
                          Text(
                            'Mulai dalam 30 menit',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF153448),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Gabung'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Kategori Pembelajaran
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('Sejarah'),
                    _buildCategoryChip('Budaya'),
                    _buildCategoryChip('Bahasa'),
                    _buildCategoryChip('Kerajinan Tangan'),
                    _buildCategoryChip('Kuliner'),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Section New Course
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kursus Terbaru',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF153448),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Lihat Semua',
                        style: TextStyle(color: Colors.grey[600])),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Grid Kartu Kursus
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                  children: [
                    _buildCourseCard(
                      'Belajar Batik',
                      'Mengenal seni dan teknik batik.',
                      Color(0xFFFDEBD0),
                      () {
                        Get.to(() => BudayaDetailPage());
                      },
                    ),
                    _buildCourseCard(
                      'Sejarah Majapahit',
                      'Menelusuri kebesaran Kerajaan Majapahit.',
                      Color(0xFFE6E8FA),
                      () {
                        Get.to(() => SejarahDetailPage());
                      },
                    ),
                    _buildCourseCard(
                      'Seni Tari Tradisional',
                      'Mempelajari berbagai tari tradisional.',
                      Color(0xFFD4F0F0),
                      () {
                        Get.to(() => BudayaDetailPage());
                      },
                    ),
                    _buildCourseCard(
                      'Pakaian Adat',
                      'Mengenal pakaian adat Nusantara.',
                      Color(0xFFDFF6E4),
                      () {
                        Get.to(() => BudayaDetailPage());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  // Widget untuk kategori chip dengan navigasi
  Widget _buildCategoryChip(String label) {
    return GestureDetector(
      onTap: () {
        if (label == 'Budaya') {
          Get.snackbar('Info', '$label kategori dipilih');
          Get.to(() => BudayaDetailPage());
        }
        if (label == 'Sejarah') {
          Get.snackbar('Info', '$label kategori dipilih');
          Get.to(() => SejarahDetailPage());
        }
        if (label == 'Bahasa') {
          Get.snackbar('Info', '$label kategori dipilih');
          Get.to(() => BahasaDetailPage());
        } else {
          Get.snackbar('Info', '$label kategori dipilih');
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFFDFD0B8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(color: Color(0xFF3C5B6F), fontSize: 14),
        ),
      ),
    );
  }
}

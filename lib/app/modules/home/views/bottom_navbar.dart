import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/views/profile_view.dart';
import 'home_view.dart';


class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  BottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF153448),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Get.offAll(() => HomeView()); // Navigasi ke Home
        } else if (index == 2) {
          Get.offAll(() => ProfilePage()); // Navigasi ke Profile
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Kursus',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }
}

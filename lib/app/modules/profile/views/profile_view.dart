import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/profile/views/my_account.dart';
import '../../home/views/bottom_navbar.dart';
import '../controllers/auth_controller.dart';
import 'account_settings_page.dart';

class ProfilePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFD0B8), // Background color for the whole screen
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40), // Padding from top
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF2E1C1), Color(0xFFDFD0B8)], // Lighter gradient for a smoother transition
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_placeholder.png'),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Text(
                          authController.userName.value,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )),
                    Obx(() => Text(
                          authController.userEmail.value,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        )),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem("112", "Following"),
                        _buildStatItem("627", "Poin"),
                        _buildStatItem("8", "Kursus"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Divider above the menu items
              const Divider(
                color: Colors.grey, // Line color
                thickness: 1, // Line thickness
                indent: 20, // Indentation from left
                endIndent: 20, // Indentation from right
              ),
              // Menu Options
              _buildMenuItem(
                icon: Icons.person_outline,
                title: "Informasi Pribadi",
                onTap: () {
                  Get.to(() => MyAccount());
                },
              ),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: "Pengaturan Akun",
                onTap: () {
                  Get.to(() => AccountSettingsPage());
                },
              ),
              _buildMenuItem(
                icon: Icons.class_outlined,
                title: "Kursus Saya",
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                title: "Notifikasi",
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.payment,
                title: "Pembayaran",
                onTap: () {},
              ),
              const SizedBox(height: 20),
              // Upgrade Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Daftar Sebagai Member",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(
                color: Colors.grey, // Line color
                thickness: 1, // Line thickness
                indent: 20, // Indentation from left
                endIndent: 20, // Indentation from right
              ),
              // Logout Button
              ListTile(
                leading: const Icon(Icons.logout, size: 30, color: Colors.red),
                title: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
                onTap: () {
                  authController.logout();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, size: 28, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}

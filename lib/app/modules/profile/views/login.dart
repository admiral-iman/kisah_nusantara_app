import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/profile/controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF153448),
              Color(0xFF3C5B6F),
              Color(0xFF948979),
              Color(0xFFDFD0B8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png', // Pastikan logo berada di folder assets
                  height: 100, // Sesuaikan ukuran logo
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20),
                Text(
                  'Kisah Nusantara',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDFD0B8),
                  ),
                ),
                SizedBox(height: 40),
                _buildTextField(emailController, 'Email', Icons.email),
                SizedBox(height: 20),
                _buildTextField(passwordController, 'Password', Icons.lock,
                    isPassword: true),
                SizedBox(height: 30),
                Obx(() {
                  return authController.isLoading.value
                      ? CircularProgressIndicator(color: Color(0xFFDFD0B8))
                      : ElevatedButton(
                          onPressed: () {
                            authController.login(
                              emailController.text,
                              passwordController.text,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF153448),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 32.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Color(0xFFDFD0B8), fontSize: 18),
                          ),
                        );
                }),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/register'); // Navigasi ke halaman Register
                  },
                  child: Text(
                    "Don't have an account? Register here",
                    style: TextStyle(color: Color(0xFFDFD0B8)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom widget untuk TextField
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Color(0xFFDFD0B8)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0x553C5B6F),
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFFDFD0B8)),
        prefixIcon: Icon(icon, color: Color(0xFFDFD0B8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color(0xFFDFD0B8), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color(0xFF153448), width: 1.5),
        ),
      ),
    );
  }
}

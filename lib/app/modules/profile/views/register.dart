import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kisah_nusantara_app/app/modules/profile/controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();

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
              children: [
                Text(
                  'Daftar Akun',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFDFD0B8),
                  ),
                ),
                SizedBox(height: 40),
                _buildTextField(nameController, 'Nama', Icons.person),
                SizedBox(height: 20),
                _buildTextField(emailController, 'Email', Icons.email),
                SizedBox(height: 20),
                _buildTextField(passwordController, 'Password', Icons.lock,
                    isPassword: true),
                SizedBox(height: 20),
                _buildDateField(
                    context, birthdayController, 'Tanggal Lahir', Icons.cake),
                SizedBox(height: 30),
                Obx(() {
                  return authController.isLoading.value
                      ? CircularProgressIndicator(color: Color(0xFFDFD0B8))
                      : ElevatedButton(
                          onPressed: () {
                            authController.register(
                              nameController.text,
                              emailController.text,
                              passwordController.text,
                              birthdayController.text,
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
                            'Register',
                            style: TextStyle(
                                color: Color(0xFFDFD0B8), fontSize: 18),
                          ),
                        );
                }),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  child: Text(
                    "Sudah punya akun? Login di sini",
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

  // Fungsi untuk menampilkan DatePicker
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF153448),
              onPrimary: Color(0xFFDFD0B8),
              surface: Color(0xFF3C5B6F),
              onSurface: Color(0xFFDFD0B8),
            ),
            dialogBackgroundColor: Color(0xFF3C5B6F),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      controller.text = formattedDate;
    }
  }

  // Widget input untuk tanggal lahir
  Widget _buildDateField(BuildContext context, TextEditingController controller,
      String label, IconData icon) {
    return TextField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(context, controller),
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

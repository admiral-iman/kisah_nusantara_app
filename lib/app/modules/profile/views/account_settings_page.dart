import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final AuthController authController = Get.find<AuthController>();
  
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  final _formKey = GlobalKey<FormState>();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  void _changePassword() async {
    if (_formKey.currentState!.validate()) {
      // Additional check to ensure new password and confirm password match
      if (_newPasswordController.text != _confirmPasswordController.text) {
        Get.snackbar(
          'Error', 
          'Konfirmasi password tidak cocok',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      try {
        // You might want to add a method in AuthController to verify current password
        await authController.editProfile(
          password: _newPasswordController.text
        );

        // Clear controllers after successful password change
        _currentPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      } catch (e) {
        Get.snackbar(
          'Error', 
          'Gagal mengubah password: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Akun'),
        backgroundColor: const Color(0xFFDFD0B8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Email Display
              const Text(
                'Email Saat ini',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 5),
              Obx(() => Text(
                authController.userEmail.value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              )),

              const SizedBox(height: 25),
              const Text(
                'Ubah Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 20),
              
              // Current Password Field
              const Text(
                'Password Sekarang',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                controller: _currentPasswordController,
                obscureText: _obscureCurrentPassword,
                decoration: InputDecoration(
                  hintText: 'Masukkan password saat ini',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureCurrentPassword 
                        ? Icons.visibility 
                        : Icons.visibility_off
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan password saat ini';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // New Password Field
              const Text(
                'Password Baru',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _obscureNewPassword,
                decoration: InputDecoration(
                  hintText: 'Masukkan password baru',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword 
                        ? Icons.visibility 
                        : Icons.visibility_off
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan password baru';
                  }
                  if (value.length < 6) {
                    return 'Password harus minimal 6 karakter';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Confirm Password Field
              const Text(
                'Konfirmasi Password Baru',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: 'Konfirmasi password baru',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword 
                        ? Icons.visibility 
                        : Icons.visibility_off
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap konfirmasi password baru';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Konfirmasi password tidak cocok';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              // Submit Button
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _changePassword,
                  child: const Text(
                    'Selesai',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFDFD0B8),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class MyAccount extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  MyAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _nameController.text = authController.userName.value;
    _birthdayController.text = authController.userBirthday.value;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profil"),
        backgroundColor: Color(0xFFDFD0B8),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70, // Mengubah radius menjadi 70
                    backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  ),
                  Positioned(
                    bottom: 10, // Menyesuaikan posisi ikon pensil
                    right: 10,  // Menyesuaikan posisi ikon pensil
                    child: Container(
                      width: 35, // Ukuran ikon pensil disesuaikan
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20, // Ukuran ikon di dalam container
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Nama
            const Text(
              "Nama",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Masukkan nama baru",
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: Icon(Icons.edit, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            // Tanggal Lahir
            const Text(
              "Tanggal Lahir",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _birthdayController,
              decoration: InputDecoration(
                hintText: "Masukkan tanggal lahir (DD-MM-YYYY)",
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                suffixIcon: Icon(Icons.edit, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            // Tombol Simpan
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  authController.editProfile(
                    name: _nameController.text,
                    birthday: _birthdayController.text,
                  );
                },
                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFDFD0B8),
    );
  }
}

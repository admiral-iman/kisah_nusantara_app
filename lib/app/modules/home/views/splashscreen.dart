import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome(); // Navigasi otomatis setelah beberapa detik
  }

  // Fungsi untuk navigasi otomatis ke halaman berikutnya
  _navigateToHome() async {
    await Future.delayed(
        Duration(seconds: 3)); // Splash screen tampil selama 3 detik
    Get.offAllNamed(AppRoutes.login); // Ganti sesuai dengan route login kamu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Menggunakan gradient sebagai background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF153448), // #153448
              Color(0xFF3C5B6F), // #3C5B6F
              Color(0xFFDFD0B8), // #DFD0B8
              Color(0xFF948979), // #948979
            ],
          ),
        ),
        // Menambahkan logo di tengah layar
        child: Center(
          child: Image.asset(
            'assets/logo.png', // Gantilah dengan path logo yang sesuai
            width: 150, // Ukuran logo, sesuaikan dengan kebutuhan
            height: 150, // Ukuran logo
          ),
        ),
      ),
    );
  }
}

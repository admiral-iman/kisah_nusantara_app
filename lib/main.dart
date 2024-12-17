import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/routes/app_pages.dart';
import 'package:kisah_nusantara_app/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kisah_nusantara_app/app/modules/profile/controllers/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Memeriksa apakah pengguna sudah login
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Menentukan halaman awal berdasarkan status login
  String initialRoute = isLoggedIn ? AppRoutes.home : AppRoutes.splash;

  // Inisialisasi AuthController di sini
  Get.put(AuthController());

  runApp(MyApp(initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kisah Nusantara',
      initialRoute:
          initialRoute, // Menggunakan initialRoute yang sudah ditentukan
      getPages: AppPages.routes, // Mendefinisikan rute dari app_pages.dart
    );
  }
}

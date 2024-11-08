import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/routes/app_pages.dart';
import 'package:kisah_nusantara_app/app/routes/app_routes.dart';
// Mengimpor routing

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kisah Nusantara',
      initialRoute:
          AppRoutes.splash, // Menggunakan splash screen sebagai halaman awal
      getPages: AppPages.routes, // Mendefinisikan rute dari app_pages.dart
    );
  }
}

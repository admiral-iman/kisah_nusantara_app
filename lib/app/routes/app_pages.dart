// app_pages.dart
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/course/budaya/views/budaya_page.dart';
import 'package:kisah_nusantara_app/app/modules/course/budaya/views/webview_budaya.dart';
import 'package:kisah_nusantara_app/app/modules/home/views/home_view.dart';
import 'package:kisah_nusantara_app/app/modules/home/views/splashscreen.dart';
import 'package:kisah_nusantara_app/app/modules/profile/views/login.dart';
import 'package:kisah_nusantara_app/app/modules/profile/views/register.dart';

import 'app_routes.dart';

class AppPages {
  // Daftar semua rute aplikasi yang didefinisikan dalam GetPage
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(), // Ganti dengan halaman login kamu
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(), // Ganti dengan halaman home kamu
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(), // Ganti dengan halaman home kamu
    ),
    GetPage(
      name: AppRoutes.budaya,
      page: () => BudayaDetailPage(),
    ),
  ];
}

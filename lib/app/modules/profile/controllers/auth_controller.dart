import 'dart:ffi';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = Rx<User?>(null);
  var userName = ''.obs; // Untuk menyimpan nama pengguna
  var userBirthday = ''.obs; // Untuk menyimpan tanggal lahir pengguna
  var userEmail = ''.obs;

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  // Fungsi untuk memeriksa status login
  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Login function
  Future<void> login(String email, String password) async {
    isLoading(true);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;

      // Ambil data pengguna dari Firestore
      await _getUserData(user.value!.uid);

      // Simpan status login
      await saveLoginStatus(true);

      Get.offAllNamed('/home'); // Redirect ke halaman home
    } catch (e) {
      Get.snackbar('Login Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  Future<void> register(
      String name, String email, String password, String birthday) async {
    isLoading(true);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user.value = userCredential.user;

      // Simpan data tambahan ke Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.value!.uid)
          .set({
        'name': name,
        'email': email,
        'birthday': birthday,
      });

      userName.value = name;
      userBirthday.value = birthday;
      userEmail.value = email;

      // Simpan status login
      await saveLoginStatus(true);

      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Register Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // Logout function
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    user.value = null;
    userName.value = '';
    userBirthday.value = '';

    // Set status login menjadi false
    await saveLoginStatus(false);

    Get.offAllNamed('/login');
  }

  // Fungsi untuk mengambil data pengguna dari Firestore
  Future<void> _getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        userName.value = userDoc['name'];
        userBirthday.value = userDoc['birthday'];
        userEmail.value = userDoc['email'];
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data pengguna',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Fungsi untuk mengedit profil pengguna
  Future<void> editProfile({
    String? name,
    String? password,
    String? birthday,
  }) async {
    isLoading(true);
    try {
      if (name != null && name.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.value!.uid)
            .update({'name': name});
        userName.value = name;
      }

      if (birthday != null && birthday.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.value!.uid)
            .update({'birthday': birthday});
        userBirthday.value = birthday;
      }

      if (password != null && password.isNotEmpty) {
        await user.value!.updatePassword(password);
      }

      Get.snackbar('Success', 'Profil berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui profil: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = Rx<User?>(null);
  var userName = ''.obs; // Untuk menyimpan nama pengguna
  var userBirthday = ''.obs; // Untuk menyimpan tanggal lahir pengguna

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
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data pengguna',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

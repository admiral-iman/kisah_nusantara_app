import 'package:get/get.dart';
import 'package:flutter/material.dart';


class PaymentController extends GetxController {
  // Observable untuk metode pembayaran
  RxString selectedPaymentMethod = ''.obs;


  // Observable untuk total pembayaran
  RxString totalPayment = '120.000'.obs;


  // Metode untuk mengatur metode pembayaran
  void setPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }


  // Metode untuk memproses pembayaran
  void processPayment() {
    // Validasi metode pembayaran
    if (selectedPaymentMethod.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Pilih metode pembayaran',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }


    // Proses pembayaran
    try {
      // Simulasi proses pembayaran
      Get.dialog(
        AlertDialog(
          title: Text('Pembayaran Berhasil'),
          content: Text('Terima kasih telah melakukan pembayaran'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Tutup dialog
                Get.back(); // Kembali ke halaman sebelumnya
              },
              child: Text('OK'),
            )
          ],
        ),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memproses pembayaran',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/payment_controller.dart';
import '../controllers/mycourse_controller.dart';

class PaymentView extends StatelessWidget {
  final PaymentController controller = Get.put(PaymentController());
  final MyCourseController courseController = Get.find<MyCourseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        title: const Text(
          'Pembayaran',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderDetails(),
            const SizedBox(height: 20),
            _buildPaymentMethods(),
            const SizedBox(height: 20),
            _buildTotalPayment(),
            const SizedBox(height: 30),
            _buildPaymentButton()
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Card(
      color: const Color(0xFF3C5B6F).withOpacity(0.4),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Pesanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Column(
                children: courseController.selectedCourses.map((courseId) {
                  final course = courseController.courses
                      .firstWhere((c) => c['id'] == courseId, orElse: () => {});
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            course['name'] ?? 'Nama tidak tersedia',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(
                          'Rp ${course['price'] ?? '100.000'}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Metode Pembayaran',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Obx(() => Column(
              children: [
                _buildPaymentMethodRadio('Transfer Bank'),
                _buildPaymentMethodRadio('E-Wallet'),
                _buildPaymentMethodRadio('Kartu Kredit'),
              ],
            )),
      ],
    );
  }

  Widget _buildPaymentMethodRadio(String method) {
    return Card(
      color: const Color(0xFF3C5B6F).withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: RadioListTile(
        activeColor: const Color(0xFFDFD0B8),
        title: Text(method),
        value: method,
        groupValue: controller.selectedPaymentMethod.value,
        onChanged: (value) {
          controller.setPaymentMethod(value.toString());
        },
      ),
    );
  }

  Widget _buildTotalPayment() {
    return Card(
      color: const Color(0xFFDFD0B8).withOpacity(0.5),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Pembayaran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Obx(() {
              double total = 0;
              for (var courseId in courseController.selectedCourses) {
                final course = courseController.courses
                    .firstWhere((c) => c['id'] == courseId, orElse: () => {});
                total += double.parse(course['price']?.toString() ?? '100000');
              }
              return Text(
                'Rp ${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.processPayment(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDFD0B8),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Bayar Sekarang',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

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
        title: Text('Pembayaran'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderDetails(),
            SizedBox(height: 20),
            _buildPaymentMethods(),
            SizedBox(height: 20),
            _buildTotalPayment(),
            SizedBox(height: 30),
            _buildPaymentButton()
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detail Pesanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Obx(() {
              return Column(
                children: courseController.selectedCourses.map((courseId) {
                  final course = courseController.courses
                      .firstWhere((c) => c['id'] == courseId, orElse: () => {});
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            course['name'] ?? 'Nama tidak tersedia',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Text(
                          'Rp ${course['price'] ?? '100.000'}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: [
                _buildPaymentMethodRadio('Transfer Bank'),
                _buildPaymentMethodRadio('E-Wallet'),
                _buildPaymentMethodRadio('Kartu Kredit'),
              ],
            ),
          ],
        ));
  }

  Widget _buildPaymentMethodRadio(String method) {
    return RadioListTile(
      title: Text(method),
      value: method,
      groupValue: controller.selectedPaymentMethod.value,
      onChanged: (value) {
        controller.setPaymentMethod(value.toString());
      },
    );
  }

  Widget _buildTotalPayment() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Pembayaran'),
                Obx(() {
                  double total = 0;
                  for (var courseId in courseController.selectedCourses) {
                    final course = courseController.courses
                        .firstWhere((c) => c['id'] == courseId, orElse: () => {});
                    total += double.parse(course['price']?.toString() ?? '100000');
                  }
                  return Text(
                    'Rp ${total.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  );
                }),
              ],
            ),
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
        child: Text('Bayar Sekarang'),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
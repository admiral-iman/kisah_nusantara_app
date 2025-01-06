import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/mycourse/controllers/mycourse_controller.dart';
import 'package:kisah_nusantara_app/app/modules/mycourse/views/payment.dart';

class MyCoursePage extends StatelessWidget {
  final MyCourseController controller = Get.put(MyCourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        title: const Text('Pilih Kelas Anda',
            style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Get.to(() => CartPage());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.courses.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemCount: controller.courses.length,
                itemBuilder: (context, index) {
                  final course = controller.courses[index];
                  return Card(
                    color: const Color(0xFFDFD0B8).withOpacity(0.3),
                    child: ListTile(
                      title: Text(course['name']),
                      subtitle: Text(course['description']),
                      trailing: Icon(
                        course['selected']
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: course['selected'] ? Colors.green : Colors.grey,
                      ),
                      onTap: () {
                        controller.toggleCourse(course['id']);
                      },
                    ),
                  );
                },
              );
            }),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total kelas dipilih: ${controller.selectedCount}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final MyCourseController controller = Get.find<MyCourseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        title: const Text('Keranjang Kelas',
            style: TextStyle(color: Colors.black)),
      ),
      body: Obx(() {
        if (controller.selectedCourses.isEmpty) {
          return const Center(child: Text('Keranjang Anda kosong.'));
        }
        return ListView.builder(
          itemCount: controller.selectedCourses.length,
          itemBuilder: (context, index) {
            final courseId = controller.selectedCourses[index];
            final course = controller.courses
                .firstWhere((c) => c['id'] == courseId, orElse: () => {});
            return Card(
              color: const Color(0xFFDFD0B8).withOpacity(0.3),
              child: ListTile(
                title: Text(course['name'] ?? 'Nama tidak tersedia'),
                subtitle:
                    Text(course['description'] ?? 'Deskripsi tidak tersedia'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: () {
                        controller.editCourse(courseId);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        controller.toggleCourse(courseId);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDFD0B8),
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            Get.to(() => PaymentView());
          },
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFD0B8),
        title: const Text('Pembayaran', style: TextStyle(color: Colors.black)),
      ),
      body: const Center(
        child: Text('Fitur pembayaran akan dikembangkan lebih lanjut.'),
      ),
    );
  }
}

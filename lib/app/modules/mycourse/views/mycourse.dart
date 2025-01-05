import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kisah_nusantara_app/app/modules/mycourse/controllers/mycourse_controller.dart';

class MyCoursePage extends StatelessWidget {
  final MyCourseController controller = Get.put(MyCourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kelas Anda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        title: const Text('Keranjang Kelas'),
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
              child: ListTile(
                title: Text(course['name'] ?? 'Nama tidak tersedia'),
                subtitle:
                    Text(course['description'] ?? 'Deskripsi tidak tersedia'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        controller.editCourse(courseId);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
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
          onPressed: () {
            Get.toNamed('/payment');
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
        title: const Text('Pembayaran'),
      ),
      body: const Center(
        child: Text('Fitur pembayaran akan dikembangkan lebih lanjut.'),
      ),
    );
  }
}

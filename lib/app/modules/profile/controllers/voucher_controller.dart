import 'package:get/get.dart';
import 'package:flutter/material.dart';


class VoucherModel {
  final String id;
  final String title;
  final String description;
  final String expiryDate;
  final bool isActive;
  final double discount;
  final String code;


  VoucherModel({
    required this.id,
    required this.title,
    required this.description,
    required this.expiryDate,
    required this.isActive,
    required this.discount,
    required this.code,
  });
}


class VoucherController extends GetxController {
  // Observable list voucher
  RxList<VoucherModel> vouchers = <VoucherModel>[].obs;


  // Total voucher
  RxInt totalVouchers = 0.obs;


  // Filter voucher aktif
  RxList<VoucherModel> get activeVouchers => 
      vouchers.where((voucher) => voucher.isActive).toList().obs;


  // Filter voucher tidak aktif
  RxList<VoucherModel> get inactiveVouchers => 
      vouchers.where((voucher) => !voucher.isActive).toList().obs;


  @override
  void onInit() {
    super.onInit();
    // Inisialisasi voucher
    fetchVouchers();
  }


  // Metode untuk mengambil voucher
  void fetchVouchers() {
    // Contoh data voucher tema natal dengan detail lengkap
    vouchers.value = [
      VoucherModel(
        id: '001',
        title: 'Diskon Natal Spesial',
        description: 'Diskon 50% untuk pembelian pertama di musim natal',
        expiryDate: '25 Desember 2023',
        isActive: true,
        discount: 50.0,
        code: 'NATAL2023',
      ),
      VoucherModel(
        id: '002',
        title: 'Hadiah Tahun Baru',
        description: 'Dapatkan potongan harga istimewa di tahun baru',
        expiryDate: '1 Januari 2024',
        isActive: true,
        discount: 30.0,
        code: 'TAHUNBARU24',
      ),
      VoucherModel(
        id: '003',
        title: 'Voucher Natal Keluarga',
        description: 'Diskon khusus untuk pembelian produk keluarga',
        expiryDate: '31 Desember 2023',
        isActive: false,
        discount: 25.0,
        code: 'KELUARGAnatal',
      ),
    ];


    // Update total voucher
    totalVouchers.value = vouchers.length;
  }


  // Metode untuk menambah voucher baru
  void addVoucher(VoucherModel newVoucher) {
    vouchers.add(newVoucher);
    totalVouchers.value = vouchers.length;
  }


  // Metode untuk menghapus voucher
  void removeVoucher(String voucherId) {
    vouchers.removeWhere((voucher) => voucher.id == voucherId);
    totalVouchers.value = vouchers.length;
  }


  // Metode untuk mengaktifkan/menonaktifkan voucher
  void toggleVoucherStatus(String voucherId) {
    int index = vouchers.indexWhere((voucher) => voucher.id == voucherId);
    if (index != -1) {
      vouchers[index] = VoucherModel(
        id: vouchers[index].id,
        title: vouchers[index].title,
        description: vouchers[index].description,
        expiryDate: vouchers[index].expiryDate,
        isActive: !vouchers[index].isActive,
        discount: vouchers[index].discount,
        code: vouchers[index].code,
      );
    }
  }


  // Metode untuk mencari voucher berdasarkan kode
  VoucherModel? findVoucherByCode(String code) {
    try {
      return vouchers.firstWhere(
        (voucher) => voucher.code.toLowerCase() == code.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }


  // Metode untuk menghitung total diskon
  double calculateDiscount(double totalHarga, String voucherCode) {
    VoucherModel? voucher = findVoucherByCode(voucherCode);
    
    if (voucher != null && voucher.isActive) {
      return totalHarga * (voucher.discount / 100);
    }
    
    return 0.0;
  }


  // Metode untuk menampilkan dialog tambah voucher
  void showAddVoucherDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final TextEditingController discountController = TextEditingController();
    final TextEditingController codeController = TextEditingController();


    Get.defaultDialog(
      title: 'Tambah Voucher Baru',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: 'Judul Voucher',
            ),
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(
              labelText: 'Deskripsi',
            ),
          ),
          TextField(
            controller: discountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Diskon (%)',
            ),
          ),
          TextField(
            controller: codeController,
            decoration: InputDecoration(
              labelText: 'Kode Voucher',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            // Validasi input
            if (titleController.text.isNotEmpty &&
                descController.text.isNotEmpty &&
                discountController.text.isNotEmpty &&
                codeController.text.isNotEmpty) {
              // Tambah voucher baru
              addVoucher(
                VoucherModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  description: descController.text,
                  expiryDate: DateTime.now()
                      .add(Duration(days: 30))
                      .toString()
                      .split(' ')[0],
                  isActive: true,
                  discount: double.parse(discountController.text),
                  code: codeController.text,
                ),
              );
              Get.back(); // Tutup dialog
              Get.snackbar(
                'Berhasil',
                'Voucher baru telah ditambahkan',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            } else {
              Get.snackbar(
                'Error',
                'Mohon isi semua field',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          },
          child: Text('Tambah'),
        ),
      ],
    );
  }
}
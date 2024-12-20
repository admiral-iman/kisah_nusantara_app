import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/voucher_controller.dart';


class VoucherView extends StatelessWidget {
  final VoucherController controller = Get.put(VoucherController());


  @override
  Widget build(BuildContext context) {
    // Warna utama dari desain Anda
    final Color primaryColor = Color(0xFFDFD0B8);
    final Color backgroundColor = Color(0xFFF5F5F5);


    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'Voucher Saya',
          style: TextStyle(
            color: Colors.brown[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.brown[800]),
            onPressed: () => controller.showAddVoucherDialog(),
          )
        ],
      ),
      body: Column(
        children: [
          // Header Voucher
          _buildVoucherHeader(primaryColor),
          
          // Daftar Voucher
          Expanded(
            child: _buildVoucherList(primaryColor),
          ),
        ],
      ),
    );
  }


  Widget _buildVoucherHeader(Color primaryColor) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Voucher',
                style: TextStyle(
                  color: Colors.brown[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Obx(() => Text(
                '${controller.totalVouchers.value} Voucher',
                style: TextStyle(
                  color: Colors.brown[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          ),
          Icon(
            Icons.confirmation_number_outlined,
            color: Colors.brown[800],
            size: 40,
          ),
        ],
      ),
    );
  }


  Widget _buildVoucherList(Color primaryColor) {
    return Obx(() => ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.vouchers.length,
      itemBuilder: (context, index) {
        var voucher = controller.vouchers[index];
        return _buildVoucherItem(voucher, primaryColor);
      },
    ));
  }


  Widget _buildVoucherItem(VoucherModel voucher, Color primaryColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Row(
          children: [
            // Sisi kiri voucher
            Container(
              width: 10,
              height: 120,
              color: voucher.isActive 
                ? primaryColor 
                : Colors.grey.shade300,
            ),
            
            // Konten voucher
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      voucher.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      voucher.description,
                      style: TextStyle(
                        color: Colors.brown[600],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Berlaku hingga: ${voucher.expiryDate}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.brown[500],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: voucher.isActive 
                              ? primaryColor.withOpacity(0.2)
                              : Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            voucher.isActive ? 'Aktif' : 'Tidak Aktif',
                            style: TextStyle(
                              color: voucher.isActive 
                                ? Colors.brown[800]
                                : Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
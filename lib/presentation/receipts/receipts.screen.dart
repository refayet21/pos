import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/widgets/drawer.dart';
import 'controllers/receipts.controller.dart';

class ReceiptsScreen extends GetView<ReceiptsController> {
  ReceiptsScreen({Key? key}) : super(key: key) {
    Get.put(ReceiptsController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'All Receipts',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.receipts.length,
            itemBuilder: (context, index) {
              List<dynamic> data = controller.receipts[index]['data'];

              List<List<dynamic>> convertedList = [];
              for (var item in data) {
                List<dynamic> items = item['items'];
                convertedList.add(items);
              }

              return Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Card(
                  child: ListTile(
                    title: Text(
                      'Receipt No: ${controller.receipts[index]['receiptNo']}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    // subtitle: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     if (receipt.data is List)
                    //       for (var item in receipt.data) Text('Item: ${item}'),
                    //     if (receipt.data is Map) Text('Data: ${receipt.data}'),
                    //   ],
                    // ),
                    // You can add more fields from the ReceiptsModel here
                    // onTap: () {
                    //   douserProductcartController.generateInvoicePdf(
                    //     controller.dousers[index]['doNo'],
                    //     controller.dousers[index]['date'],
                    //     controller.dousers[index]['userId'],
                    //     controller.dousers[index]['marketingPerson'],
                    //     controller.dousers[index]['vendorName'],
                    //     controller.dousers[index]['vendorAddress'],
                    //     controller.dousers[index]['contactPerson'],
                    //     controller.dousers[index]['vendorMobile'],
                    //     convertedList,
                    //     controller.dousers[index]['totalInWord'],
                    //     controller.dousers[index]['deliveryDate'],
                    //   );
                    // },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

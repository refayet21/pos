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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${controller.receipts[index]['date']}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Total Price: ${controller.receipts[index]['totalPrice']}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.print,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    ),
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

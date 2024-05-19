import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/receipts.controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loyverspos/widgets/drawer.dart';

class ReceiptsScreen extends GetView<ReceiptsController> {
  ReceiptsScreen({Key? key}) : super(key: key) {
    // Initialize the controller outside of the build method
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
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Expanded(
            child: Obx(
              () {
                // Listen to changes in findreceipts
                return ListView.builder(
                  itemCount: controller.findreceipts.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.grey.shade200,
                    child: ListTile(
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3.h),
                          Text(
                            'Receipt No : ${controller.findreceipts[index].receiptNo}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3.h),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

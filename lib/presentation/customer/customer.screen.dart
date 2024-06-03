import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loyverspos/infrastructure/navigation/routes.dart';
import 'package:loyverspos/widgets/drawer.dart';
import 'package:loyverspos/widgets/user_drawer.dart';
import 'controllers/customer.controller.dart';

class CustomerScreen extends GetView<CustomerController> {
  final box = GetStorage();
  CustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: box.read('adminemail') != null ? AdminDrawer() : UserDrawer(),
      appBar: AppBar(
        title: Text('User Info'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2.r,
                            blurRadius: 10.r,
                            offset: Offset(0, 3),
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: -2.r,
                            blurRadius: 10.r,
                            offset: Offset(-3, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${controller.employeeName.value}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Address: ${controller.employeeaddress.value}",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Mobile: ${controller.employeemobile.value}",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Email: ${controller.employeeemail.value}",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

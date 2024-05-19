import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/widgets/customFullScreenDialog.dart';
import 'package:loyverspos/widgets/customSnackBar.dart';

class SalesController extends GetxController {
  // Future<bool> saveReceipts(ReceiptsModel receipts) async {
  //   // if (receipts == null) return false;

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("receipts")
  //         .add(receipts.toMap());

  //     return true;
  //   } catch (e) {
  //     print('Error saving delivery order: ${e.toString()}');
  //     return false;
  //   }
  // }

  Future<bool> saveReceipts(ReceiptsModel receipts) async {
    try {
      await FirebaseFirestore.instance
          .collection("receipts")
          .add(receipts.toMap())
          .whenComplete(() => CustomSnackBar.showSnackBar(
                context: Get.context,
                title: "Saved successfully",
                message: "",
                // toastLength: Toast.LENGTH_SHORT,
                // gravity: ToastGravity.BOTTOM,
                // timeInSecForIosWeb: 2,
                backgroundColor: Colors.grey.shade100,

                // textColor: Colors.white,
                // fontSize: 16.sp,
              ));

      // Show success toast

      return true;
    } catch (e) {
      print('Error saving delivery order: ${e.toString()}');

      // Show error toast
      // Fluttertoast.showToast(
      //   msg: "Error saving receipt",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 3,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.sp,
      // );

      return false;
    }
  }
}

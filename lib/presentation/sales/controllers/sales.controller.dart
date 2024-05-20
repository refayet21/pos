import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loyverspos/infrastructure/navigation/routes.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/widgets/customFullScreenDialog.dart';
import 'package:loyverspos/widgets/customSnackBar.dart';

class SalesController extends GetxController {
  Future<bool> saveReceipts(ReceiptsModel receipts) async {
    try {
      await FirebaseFirestore.instance
          .collection("receipts")
          .add(receipts.toMap())
          .whenComplete(() => CustomSnackBar.showSnackBar(
                context: Get.context,
                title: "Saved successfully",
                message: "",
                backgroundColor: Colors.grey.shade100,
              ));
      Get.toNamed(Routes.RECEIPTS);

      return true;
    } catch (e) {
      print('Error saving delivery order: ${e.toString()}');

      return false;
    }
  }
}

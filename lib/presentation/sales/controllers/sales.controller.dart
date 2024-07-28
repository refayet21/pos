import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loyverspos/infrastructure/navigation/routes.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/model/userModel.dart';
import 'package:loyverspos/widgets/customFullScreenDialog.dart';
import 'package:loyverspos/widgets/customSnackBar.dart';

class SalesController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  RxList<UserModel> users = RxList<UserModel>([]);
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("users");
    getAllusers().listen((user) {
      users.assignAll(user);
    });
  }

  Stream<List<UserModel>> getAllusers() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => UserModel.fromJson(item)).toList());

  Future<bool> saveReceipts(ReceiptsModel receipts) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(box.read('employeeId'))
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

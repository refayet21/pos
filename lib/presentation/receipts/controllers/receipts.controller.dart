import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptsController extends GetxController {
  RxList<Map<String, dynamic>> receipts = RxList<Map<String, dynamic>>();

  RxList<ReceiptsModel> findreceipts = RxList<ReceiptsModel>([]);
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;

  @override
  void onInit() {
    super.onInit();

    getUserDo();
  }

  Stream<List<ReceiptsModel>> getAllReceipts() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ReceiptsModel.fromMap(item)).toList());
  Future<void> getUserDo() async {
    final QuerySnapshot<Map<String, dynamic>> questionsQuery =
        await FirebaseFirestore.instance.collection("receipts").get();
    receipts.value = questionsQuery.docs.map((doc) => doc.data()).toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/receiptsModel.dart';

class ReceiptsController extends GetxController {
  RxList<ReceiptsModel> receipts = RxList<ReceiptsModel>([]);
  RxList<ReceiptsModel> findreceipts = RxList<ReceiptsModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  // RxList<VendorModel> vendors = RxList<VendorModel>([]);

  @override
  void onInit() {
    super.onInit();

    collectionReference = firebaseFirestore.collection("receipts");
    getAllReceipts().listen((receipt) {
      receipts.assignAll(receipt);
      findreceipts.assignAll(receipts);
      // print(findvendors);
    });
  }

  Stream<List<ReceiptsModel>> getAllReceipts() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ReceiptsModel.fromMap(item)).toList());

  void filterReceipt(String receipt) {
    List<ReceiptsModel> results;
    if (receipt.isEmpty) {
      results = receipts;
    } else {
      results = receipts
          .where((element) => element.totalPrice
              .toString()
              .toLowerCase()
              .contains(receipt.toLowerCase()))
          .toList();
    }
    findreceipts.value = results;
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:loyverspos/model/receiptsModel.dart';

// class ReceiptsController extends GetxController {
//   RxList<ReceiptsModel> receipts = RxList<ReceiptsModel>([]);
//   RxList<ReceiptsModel> findreceipts = RxList<ReceiptsModel>([]);

//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   late CollectionReference collectionReference;

//   @override
//   void onInit() {
//     super.onInit();
//     collectionReference = firebaseFirestore.collection("receipts");
//     getAllReceipts().listen((receipt) {
//       receipts.assignAll(receipt);
//       findreceipts.assignAll(receipts);
//     });
//   }

//   Stream<List<ReceiptsModel>> getAllReceipts() =>
//       collectionReference.snapshots().map((query) =>
//           query.docs.map((item) => ReceiptsModel.fromMap(item)).toList());

//   void filterReceipt(String receipt) {
//     List<ReceiptsModel> results;
//     if (receipt.isEmpty) {
//       results = receipts;
//     } else {
//       results = receipts
//           .where((element) => element.totalPrice
//               .toString()
//               .toLowerCase()
//               .contains(receipt.toLowerCase()))
//           .toList();
//     }
//     findreceipts.value = results;
//   }

//   Future<bool> saveReceipts(ReceiptsModel receipts) async {
//     try {
//       await collectionReference.add(receipts.toMap());

//       // Show success toast
//       Fluttertoast.showToast(
//         msg: "Receipt saved successfully",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );

//       return true;
//     } catch (e) {
//       // Show error toast
//       Fluttertoast.showToast(
//         msg: "Error saving receipt",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );

//       print('Error saving receipt: ${e.toString()}');
//       return false;
//     }
//   }
// }

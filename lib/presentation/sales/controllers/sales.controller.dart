import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/receiptsModel.dart';

class SalesController extends GetxController {
  Future<bool> saveReceipts(ReceiptsModel receipts) async {
    // if (receipts == null) return false;

    try {
      await FirebaseFirestore.instance
          .collection("receipts")
          .add(receipts.toMap()); // Use add instead of set
      return true;
    } catch (e) {
      print('Error saving delivery order: ${e.toString()}');
      return false;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/presentation/invoicepreview/invoicepreview.screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReceiptsController extends GetxController {
  RxList<Map<String, dynamic>> receipts = RxList<Map<String, dynamic>>();

  RxList<ReceiptsModel> findreceipts = RxList<ReceiptsModel>([]);
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  final box = GetStorage();
  var employeeName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getUserInfoAndRecord();
    getUserDo();
  }

  Future<void> _getUserInfoAndRecord() async {
    try {
      String email = box.read('useremail');
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: email)
          .get();
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      // employeeId.value = userDoc.id;
      employeeName.value = userDoc['name'];

      // box.write('employeeId', userDoc.id);
    } catch (e) {}
  }

  Stream<List<ReceiptsModel>> getAllReceipts() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ReceiptsModel.fromMap(item)).toList());
  Future<void> getUserDo() async {
    final QuerySnapshot<Map<String, dynamic>> questionsQuery =
        await FirebaseFirestore.instance.collection("receipts").get();
    receipts.value = questionsQuery.docs.map((doc) => doc.data()).toList();
  }

  Future<void> generateInvoicePdf(String receiptNo, String date,
      List<List<dynamic>> data, String totalPrice) async {
    final doc = pw.Document();

    try {
      final tableHeaders = [
        'Product',
        'Price',
        'Quantity',
        'Total',
      ];

      doc.addPage(
        pw.Page(
          margin:
              pw.EdgeInsets.only(top: 3, right: 10.w, bottom: 6, left: 10.w),
          pageFormat: PdfPageFormat.roll80,
          build: (context) {
            return pw.Column(
              children: [
                pw.Container(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Text(
                              'Invoice',
                              style: pw.TextStyle(
                                fontSize: 20.sp,
                                fontWeight: pw.FontWeight.bold,
                                decoration: pw.TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Receipt No: $receiptNo"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Sales Person: $employeeName"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Date: $date"),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Table.fromTextArray(
                  headers: tableHeaders,
                  data: data,
                  cellStyle: pw.TextStyle(
                    fontSize: 7.sp,
                  ),
                  border: pw.TableBorder.all(),
                  headerStyle: pw.TextStyle(
                    fontSize: 7.sp,
                  ),
                ),
                pw.SizedBox(height: 10.h),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Total Price: $totalPrice',
                  style: pw.TextStyle(
                    fontSize: 11.0,
                  ),
                ),
              ],
            );
          },
        ),
      );

      Get.to(() => InvoicepreviewScreen(
            doc: doc,
            pdfname: receiptNo,
          ));
    } catch (e) {
      // Handle the error, e.g., print('Error: $e');
    }
  }
}

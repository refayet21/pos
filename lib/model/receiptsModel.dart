import 'package:cloud_firestore/cloud_firestore.dart';

class ReceiptsModel {
  final String receiptNo;
  final String date;
  final List<String> data;
  final dynamic totalPrice;

  ReceiptsModel({
    required this.receiptNo,
    required this.date,
    required this.data,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'receiptNo': receiptNo,
      'date': date,
      'data': data.map((list) => {'items': list}).toList(),
      'totalPrice': totalPrice,
    };
  }

  // Create a DeliveryOrder object from a Map
  // factory ReceiptsModel.fromMap(DocumentSnapshot data) {
  //   return ReceiptsModel(
  //     receiptNo: data['receiptNo'],
  //     date: data['date'],
  //     data: List<String>.from(data['data']),
  //     totalPrice: data['totalPrice'],
  //   );
  // }

  factory ReceiptsModel.fromMap(QueryDocumentSnapshot data) {
    return ReceiptsModel(
      receiptNo: data['receiptNo'] as String,
      date: data['date'] as String,
      data: List<String>.from(data['data'] as List<dynamic>),
      totalPrice: data['totalPrice'],
    );
  }
}

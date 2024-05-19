class ReceiptsModel {
  final String receiptNo;
  final String date;
  final List<List<dynamic>> data;
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
  factory ReceiptsModel.fromMap(Map<String, dynamic> map) {
    return ReceiptsModel(
      receiptNo: map['receiptNo'],
      date: map['date'],
      data: List<List<dynamic>>.from(map['data']),
      totalPrice: map['totalPrice'],
    );
  }
}

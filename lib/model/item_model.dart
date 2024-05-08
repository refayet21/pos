import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? docId;
  String? name;
  String? category;
  String? soldBy;
  int? price;
  int? cost;
  String? barcode;
  int? stock;

  ItemModel({
    this.docId,
    this.name,
    this.category,
    this.soldBy,
    this.price,
    this.cost,
    this.barcode,
    this.stock,
  });

  // Convert DocumentSnapshot to ItemModel object
  ItemModel.fromJson(DocumentSnapshot data)
      : docId = data.id,
        name = data["name"] as String?,
        category = data["category"] as String?,
        soldBy = data["soldBy"] as String?,
        price = data["price"] as int?,
        cost = data["cost"] as int?,
        barcode = data["barcode"] as String?,
        stock = data["stock"] as int?;

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'category': category,
      'soldBy': soldBy,
      'price': price,
      'cost': cost,
      'barcode': barcode,
      'stock': stock,
    };
  }
}

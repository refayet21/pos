// class ItemModel {
//   int? id;
//   String name;
//   String barcode;
//   double price;
//   int quantity;

//   ItemModel({
//     this.id,
//     required this.name,
//     required this.barcode,
//     required this.price,
//     this.quantity = 1,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'barcode': barcode,
//       'price': price,
//     };
//   }

//   factory ItemModel.fromMap(Map<String, dynamic> map) {
//     return ItemModel(
//       id: map['id'],
//       name: map['name'],
//       barcode: map['barcode'],
//       price: map['price'],
//     );
//   }
// }

import 'package:get/get.dart';
import 'package:get/get.dart';

class ItemModel {
  String? id; // Firestore document ID
  String name;
  String barcode;
  double price;
  int? quantity;
  RxInt newQuantity; // Make newQuantity an observable field

  ItemModel({
    this.id,
    required this.name,
    required this.barcode,
    required this.price,
    this.quantity,
    int newQuantity = 1,
  }) : newQuantity = newQuantity.obs;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'barcode': barcode,
      'price': price,
      'quantity': quantity,
      'newQuantity': newQuantity.value,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return ItemModel(
      id: id,
      name: map['name'],
      barcode: map['barcode'],
      price: map['price'],
      quantity: map['quantity'],
      newQuantity: map['newQuantity'] ?? 1,
    );
  }
}

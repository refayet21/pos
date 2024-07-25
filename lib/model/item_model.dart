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

class ItemModel {
  String? id; // Firestore document ID
  String name;
  String barcode;
  double price;
  int quantity;

  ItemModel({
    this.id,
    required this.name,
    required this.barcode,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'barcode': barcode,
      'price': price,
      'quantity': quantity,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return ItemModel(
      id: id,
      name: map['name'],
      barcode: map['barcode'],
      price: map['price'],
      quantity: map['quantity'] ?? 1,
    );
  }
}

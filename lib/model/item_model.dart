// class ItemModel {
//   String? docId;
//   String? name;
//   String? category;
//   String? soldBy;
//   int? price;
//   int? cost;
//   String? barcode;
//   int? stock;

//   ItemModel({
//     this.docId,
//     this.name,
//     this.category,
//     this.soldBy,
//     this.price,
//     this.cost,
//     this.barcode,
//     this.stock,
//   });

//   // Convert DocumentSnapshot to ItemModel object
// factory   ItemModel.fromJson(Map<dynamic, dynamic> json)
//       : docId = data.id,
//         name = data["name"] as String?,
//         category = data["category"] as String?,
//         soldBy = data["soldBy"] as String?,
//         price = data["price"] as int?,
//         cost = data["cost"] as int?,
//         barcode = data["barcode"] as String?,
//         stock = data["stock"] as int?;

//   Map<String, dynamic> toJson() {
//     return {
//       'docId': docId,
//       'name': name,
//       'category': category,
//       'soldBy': soldBy,
//       'price': price,
//       'cost': cost,
//       'barcode': barcode,
//       'stock': stock,
//     };
//   }
// }
class ItemModel {
  int? id;
  String? name;
  // String? category;
  // String? soldBy;
  // int? price;
  // int? cost;
  // String? barcode;
  // int? stock;

  ItemModel({
    this.id,
    this.name,
    // this.category,
    // this.soldBy,
    // this.price,
    // this.cost,
    // this.barcode,
    // this.stock
  });

  factory ItemModel.fromMap(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
      // category: json['category'],
      // soldBy: json['soldBy'],
      // price: json['price'],
      // cost: json['cost'],
      // barcode: json['barcode'],
      // stock: json['stock'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      // 'category': category,
      // 'soldBy': soldBy,
      // 'price': price,
      // 'cost': cost,
      // 'barcode': barcode,
      // 'stock': stock,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? docId;
  String? name;

  CategoryModel({
    this.docId,
    this.name,
  });

  CategoryModel.fromJson(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"] as String?;
  }

  // Convert VendorModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
    };
  }
}

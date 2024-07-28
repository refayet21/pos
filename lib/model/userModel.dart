import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? docId;
  String? name;
  String? address;
  String? mobile;
  String? email;
  String? password;
  int? receiptSerial;

  UserModel(
      {this.docId,
      this.name,
      this.address,
      this.mobile,
      this.email,
      this.password,
      this.receiptSerial});

  UserModel.fromJson(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"];
    address = data["address"];
    mobile = data["mobile"];
    email = data["email"];
    password = data["password"];
    receiptSerial = data["receiptSerial"];
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'address': address,
      'mobile': mobile,
      'email': email,
      'password': password,
      'receiptSerial': receiptSerial,
    };
  }
}

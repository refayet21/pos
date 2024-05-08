import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  String? docId;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? region;
  String? postalCode;
  String? country;

  CustomerModel({
    this.docId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.region,
    this.postalCode,
    this.country,
  });

  CustomerModel.fromJson(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"] as String?;
    email = data["email"] as String?;
    phone = data["phone"] as String?;
    address = data["address"] as String?;
    city = data["city"] as String?;
    region = data["region"] as String?;
    postalCode = data["postalCode"] as String?;
    country = data["country"] as String?;
  }

  // Convert CustomerModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'region': region,
      'postalCode': postalCode,
      'country': country,
    };
  }
}

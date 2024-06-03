import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerController extends GetxController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  final box = GetStorage();

  // var employeeId = ''.obs;
  var employeeName = ''.obs;
  var employeeaddress = ''.obs;
  var employeemobile = ''.obs;
  var employeeemail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _getUserInfoAndRecord();
  }

  @override
  void onReady() {
    super.onReady();

    // _getRecord();
  }

  Future<void> logout() {
    return _auth.signOut();
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
      employeeaddress.value = userDoc['address'];
      employeemobile.value = userDoc['mobile'];
      employeeemail.value = userDoc['email'];
      // box.write('employeeId', userDoc.id);
    } catch (e) {}
  }
}

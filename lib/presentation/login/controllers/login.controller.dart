import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loyverspos/infrastructure/navigation/routes.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final box = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isLoading = false.obs;

  Future<User?> login(String email, String password) async {
    try {
      isLoading.value = true;

      bool isAdmin = await checkUserCredentials('admin', email, password);
      bool isUser = await checkUserCredentials('users', email, password);

      if (isAdmin) {
        box.write('adminemail', email);
        Get.offNamed(Routes.HOME);
        return null;
      } else if (isUser) {
        box.write('useremail', email);
        Get.offNamed(Routes.HOME);
        // Get.offNamed(Routes.DOUSER_INVOICE);
        return null; // No need to return User object for DoUser
      } else {
        // User not found in any collection
        Get.snackbar(
          'Error',
          'User does not exist.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: Icon(Icons.error),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      // }
    } catch (e) {
      // Handle any unexpected errors
      // print('Error: $e');
    } finally {
      isLoading.value =
          false; // Set loading state to false after login process completes
    }

    return null;
  }

  // Future<bool> checkAdminAuthentication(String email, String password) async {
  //   try {
  //     final credential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return credential.user != null;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<bool> checkUserCredentials(
  //     String collection, String email, String password) async {

  //   try {
  //     final querySnapshot = await _firestore
  //         .collection(collection)
  //         .where('email', isEqualTo: email)
  //         .where('password', isEqualTo: password)
  //         .get();
  //     return querySnapshot.docs.isNotEmpty;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<bool> checkUserCredentials(
      String collection, String email, String password) async {
    try {
      // Check authentication via Firebase Authentication
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if user exists in Firestore collection
      final querySnapshot = await _firestore
          .collection(collection)
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      // Return true only if both conditions are met
      return credential.user != null && querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Handle any unexpected errors
      // print('Error: $e');
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

    emailController.dispose();
    passwordController.dispose();
  }
}

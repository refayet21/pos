import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/userModel.dart';
import 'package:loyverspos/widgets/customFullScreenDialog.dart';
import 'package:loyverspos/widgets/customSnackBar.dart';

class AdduserController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  late String oldPassword;

  late TextEditingController nameController,
      addressController,
      mobileController,
      emailController,
      passwordController;
  RxList<UserModel> founduser = RxList<UserModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  // RxList<userModel> users = RxList<userModel>([]);
  RxList<UserModel> users = RxList<UserModel>([]);
  Stream<List<UserModel>> getAllusers() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => UserModel.fromJson(item)).toList());

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    collectionReference = firebaseFirestore.collection("users");
    // users.bindStream(getAllusers());
    // founduser = users;
    getAllusers().listen((user) {
      users.assignAll(user);
      founduser.assignAll(users);

      // Print foundProduct after it's assigned
      // print(foundProduct);
    });
  }

  void saveUpdateusers(
    String? name,
    String? address,
    String? mobile,
    String email,
    String password,
    String? docId,
    int? addEditFlag,
  ) async {
    try {
      if (addEditFlag == 1) {
        CustomFullScreenDialog.showDialog();
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await collectionReference.add({
          'name': name,
          'address': address,
          'mobile': mobile,
          'email': email,
          'password': password,
        });
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "User Added",
          message: "User added successfully",
          backgroundColor: Colors.green,
        );
      } else if (addEditFlag == 2) {
        //update
        CustomFullScreenDialog.showDialog();

        // var cred =
        //     EmailAuthProvider.credential(email: email, password: oldPassword);
        // await currentUser!.reauthenticateWithCredential(cred);
        // await currentUser!.updatePassword(password);
        // print('oldPassword is $oldPassword new password is $password');

        await collectionReference.doc(docId).update({
          'name': name,
          'address': address,
          'mobile': mobile,
          'email': email,
          'password': password,
        });
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "User Updated",
          message: "User updated successfully",
          backgroundColor: Colors.green,
        );
      }
    } catch (error) {
      // print('error is $error');
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
        context: Get.context,
        title: "Error",
        message: "Something went wrong: $error",
        backgroundColor: Colors.red,
      );
    }
  }

  // void saveUpdateusers(
  //   String? name,
  //   String? address,
  //   String? mobile,
  //   String email,
  //   String password,
  //   String? docId,
  //   int? addEditFlag,
  // ) async {
  //   final isValid = formKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   formKey.currentState!.save();

  //   if (addEditFlag == 1) {
  //     // Create new user
  //     CustomFullScreenDialog.showDialog();
  //     try {
  //       await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );

  //       // Add user info to Firestore
  //       await collectionReference.add({
  //         'name': name,
  //         'address': address,
  //         'mobile': mobile,
  //         'email': email,
  //       });

  //       CustomFullScreenDialog.cancelDialog();
  //       clearEditingControllers();
  //       Get.back();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Do User Added",
  //         message: "Do User added successfully",
  //         backgroundColor: Colors.green,
  //       );
  //     } catch (error) {
  //       CustomFullScreenDialog.cancelDialog();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Error",
  //         message: error.toString(),
  //         backgroundColor: Colors.red,
  //       );
  //     }
  //   } else if (addEditFlag == 2) {
  //     // Update existing user
  //     CustomFullScreenDialog.showDialog();
  //     try {
  //       // Update authentication email if necessary
  //       currentUser user = _auth.currentUser!;
  //       if (user.email != email) {
  //         await user.updateEmail(email);
  //       }

  //       // Update authentication password if necessary
  //       if (password.isNotEmpty) {
  //         await user.updatePassword(password);
  //       }

  //       // Update user info in Firestore
  //       await collectionReference.doc(docId).update({
  //         'name': name,
  //         'address': address,
  //         'mobile': mobile,
  //         'email': email,
  //       });

  //       CustomFullScreenDialog.cancelDialog();
  //       clearEditingControllers();
  //       Get.back();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Do User Updated",
  //         message: "Do User updated successfully",
  //         backgroundColor: Colors.green,
  //       );
  //     } catch (error) {
  //       CustomFullScreenDialog.cancelDialog();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Error",
  //         message: error.toString(),
  //         backgroundColor: Colors.red,
  //       );
  //     }
  //   }
  // }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void clearEditingControllers() {
    nameController.clear();
    addressController.clear();
    mobileController.clear();
    emailController.clear();
    passwordController.clear();
  }

  // Stream<List<userModel>> getAllusers() =>
  //     collectionReference.snapshots().map((query) =>
  //         query.docs.map((item) => userModel.fromJson(item)).toList());

  // void deleteData(String docId) {
  //   CustomFullScreenDialog.showDialog();

  //   // _fireStore.collection(CollectioName).doc(doc_id).delete();

  //   // collectionReference.doc(docId).delete()
  //   firebaseFirestore
  //       .collection("do_users")
  //       .doc(docId)
  //       .delete()
  //       .whenComplete(() {
  //     CustomFullScreenDialog.cancelDialog();
  //     Get.back();
  //     CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Do User Deleted",
  //         message: "Do User deleted successfully",
  //         backgroundColor: Colors.green);
  //   }).catchError((error) {
  //     CustomFullScreenDialog.cancelDialog();
  //     CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Error",
  //         message: "Something went wrong",
  //         backgroundColor: Colors.red);
  //   });
  // }

  void deleteData(String docId) async {
    CustomFullScreenDialog.showDialog();

    try {
      // First, delete the document itself
      await firebaseFirestore.collection("users").doc(docId).delete();

      // Then, delete all subcollections
      await _deleteSubcollections("users/$docId");

      CustomFullScreenDialog.cancelDialog();
      Get.back(); // Assuming you're using GetX for navigation
      CustomSnackBar.showSnackBar(
        context: Get.context,
        title: "User Deleted",
        message: "User deleted successfully",
        backgroundColor: Colors.green,
      );
    } catch (error) {
      CustomFullScreenDialog.cancelDialog();
      // print("Error deleting document: $error"); // Log the error for debugging
      CustomSnackBar.showSnackBar(
        context: Get.context,
        title: "Error",
        message: "Something went wrong",
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _deleteSubcollections(String docPath) async {
    try {
      final DocumentSnapshot docSnapshot =
          await firebaseFirestore.doc(docPath).get();

      // Check if the document exists
      if (!docSnapshot.exists) {
        // print("Document doesn't exist: $docPath");
        return;
      }

      // Get the data from the document as a Map<String, dynamic>
      final Map<String, dynamic>? data =
          docSnapshot.data() as Map<String, dynamic>?;

      // Check if the document has any subcollections
      if (data == null || data.isEmpty) {
        // No subcollections, directly delete the document
        await docSnapshot.reference.delete();
        return;
      }

      final List<Future<void>> deleteFutures = [];

      // Iterate over each key (subcollection name) in the document's data
      for (final key in data.keys) {
        // Ignore fields that are not subcollections
        if (data[key] is! Map<String, dynamic>) {
          continue;
        }

        final QuerySnapshot subcollectionSnapshot =
            await docSnapshot.reference.collection(key).get();

        // Delete all documents in the subcollection
        for (final doc in subcollectionSnapshot.docs) {
          deleteFutures.add(doc.reference.delete());
        }
      }

      // Wait for all deletion operations to complete
      await Future.wait(deleteFutures);

      // After deleting subcollections, delete the document itself
      await docSnapshot.reference.delete();
    } catch (e) {
      // print("Error deleting subcollections: $e");
    }
  }

  // void searchuser(String searchQuery) {
  //   if (searchQuery.isEmpty) {
  //     founduser.assignAll(users.toList());
  //   } else {
  //     List<userModel> results = users
  //         .where((element) =>
  //             element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
  //         .toList();
  //     founduser.assignAll(results);
  //   }
  // }

  void searchuser(String searchQuery) {
    List<UserModel> results;
    if (searchQuery.isEmpty) {
      results = users;
    } else {
      results = users
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
    founduser.value = results;
  }
}

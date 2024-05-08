import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/widgets/customFullScreenDialog.dart';
import 'package:loyverspos/widgets/customSnackBar.dart';

class ItemController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      categoryController,
      soldByController,
      priceController,
      costController,
      barcodeController,
      stockController;
  RxList<ItemModel> findItem = RxList<ItemModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<ItemModel> items = RxList<ItemModel>([]);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    categoryController = TextEditingController();

    soldByController = TextEditingController();
    priceController = TextEditingController();
    costController = TextEditingController();
    barcodeController = TextEditingController();
    stockController = TextEditingController();

    collectionReference = firebaseFirestore.collection("items");
    // Products.bindStream(getAllProducts());
    // foundProduct = Products;
    getAllItems().listen((item) {
      items.assignAll(item);
      findItem.assignAll(items);

      // Print foundProduct after it's assigned
      // print(foundProduct);
    });
  }

  // String? validateName(String value) {
  //   if (value.isEmpty) {
  //     return "Name can not be empty";
  //   }
  //   return null;
  // }

  // String? validatecategory(String value) {
  //   if (value.isEmpty) {
  //     return "category can not be empty";
  //   }
  //   return null;
  // }

  // void saveUpdateProduct(
  //     ProductModel productModel, String docId, int addEditFlag) {
  //   final currentState = formKey.currentState;
  //   if (currentState == null) return;

  //   final isValid = currentState.validate();
  //   if (!isValid) return;

  //   currentState.save();

  //   final isAdding = addEditFlag == 1;
  //   final isUpdating = addEditFlag == 2;

  //   if (isAdding || isUpdating) {
  //     final dialogMessage = isAdding ? "Product Added" : "Product Updated";
  //     final successMessage = isAdding
  //         ? "Product added successfully"
  //         : "Product updated successfully";

  //     CustomFullScreenDialog.showDialog();

  //     Future<void> operation;
  //     if (isAdding) {
  //       // For adding, simply add the new product
  //       operation = collectionReference.add(productModel.toJson());
  //     } else {
  //       // For updating, fetch the current document and update its stock value
  //       operation = collectionReference.doc(docId).get().then((docSnapshot) {
  //         if (docSnapshot.exists) {
  //           // Fetch previous stock value
  //           final data = docSnapshot.data()
  //               as Map<String, dynamic>?; // Cast to Map<String, dynamic>
  //           int previousStock = data?['stock'] as int? ?? 0;
  //           // Calculate new stock value
  //           int newStock = previousStock + (productModel.stock ?? 0);
  //           // Update the stock value in the productModel
  //           productModel.stock = newStock;
  //           // Update the document with the updated productModel
  //           return collectionReference.doc(docId).update(productModel.toJson());
  //         } else {
  //           // Handle case where document doesn't exist
  //           return Future.error("Document does not exist");
  //         }
  //       });
  //     }

  //     operation.then((_) {
  //       CustomFullScreenDialog.cancelDialog();
  //       clearEditingControllers();
  //       Get.back();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: dialogMessage,
  //         message: successMessage,
  //         backgroundColor: Colors.green,
  //       );
  //     }).catchError((error) {
  //       CustomFullScreenDialog.cancelDialog();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Error",
  //         message: "Something went wrong: $error",
  //         backgroundColor: Colors.red,
  //       );
  //     });
  //   }
  // }

  void saveUpdateItem(ItemModel itemModel, String docId, int addEditFlag) {
    final currentState = formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();
    if (!isValid) return;

    currentState.save();

    final isAdding = addEditFlag == 1;
    final isUpdating = addEditFlag == 2;

    if (isAdding || isUpdating) {
      final dialogMessage = isAdding ? "Item Added" : "Item Updated";
      final successMessage =
          isAdding ? "Item added successfully" : "Item updated successfully";

      CustomFullScreenDialog.showDialog();

      Future<void> operation;
      if (isAdding) {
        operation = collectionReference.add(itemModel.toJson());
      } else {
        operation = collectionReference.doc(docId).update(itemModel.toJson());
      }

      operation.then((_) {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: dialogMessage,
          message: successMessage,
          backgroundColor: Colors.green,
        );
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong: $error",
          backgroundColor: Colors.red,
        );
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    categoryController.dispose();

    soldByController.dispose();
    priceController.dispose();
    costController.dispose();
    barcodeController.dispose();
    stockController.dispose();
  }

  void clearEditingControllers() {
    nameController.clear();
    categoryController.clear();
    soldByController.clear();
    priceController.clear();
    costController.clear();
    barcodeController.clear();
    stockController.clear();
  }

  Stream<List<ItemModel>> getAllItems() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => ItemModel.fromJson(item)).toList());

  Stream<Map<String, List<ItemModel>>> getAllProductsGroupedByCategory() =>
      collectionReference.snapshots().map((query) {
        Map<String, List<ItemModel>> groupedProducts = {};
        query.docs.forEach((doc) {
          ItemModel product = ItemModel.fromJson(doc);
          String category = product.category ?? "Other";
          if (!groupedProducts.containsKey(category)) {
            groupedProducts[category] = [];
          }
          groupedProducts[category]!.add(product);
        });
        return groupedProducts;
      });

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Product Deleted",
          message: "Product deleted successfully",
          backgroundColor: Colors.green);
    }).catchError((error) {
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong",
          backgroundColor: Colors.red);
    });
  }

  void searchItem(String ItemName) {
    List<ItemModel> results;
    if (ItemName.isEmpty) {
      results = items;
    } else {
      results = items
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(ItemName.toLowerCase()))
          .toList();
    }
    findItem.value = results;
  }
}

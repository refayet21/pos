import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/domain/DBHelper.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/widgets/customFullScreenDialog.dart';
import 'package:loyverspos/widgets/customSnackBar.dart';

class ItemController extends GetxController {
  var allItems = <ItemModel>[].obs;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  void fetchAllItems() async {
    var items = await databaseHelper.getItems();
    allItems.value = items;
  }

  void addItem(ItemModel item) async {
    await databaseHelper.addItem(item);
    fetchAllItems();
  }

  void updateItem(ItemModel item) async {
    await databaseHelper.updateItem(item);
    fetchAllItems();
  }

  void deleteItem(int id) async {
    await databaseHelper.deleteItem(id);
    fetchAllItems();
  }
}

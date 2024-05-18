import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/domain/DBHelper.dart';
import 'package:loyverspos/model/item_model.dart';

class HomeController extends GetxController {
  // var allItems = <ItemModel>[].obs;
  RxList<ItemModel> allItems = RxList<ItemModel>([]);

  final DatabaseHelper databaseHelper = DatabaseHelper();
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  void fetchAllItems() async {
    var items = await databaseHelper.getItems();
    allItems.value = items;
  }

  var cartItems = <ItemModel>[].obs;

  double get totalPrice =>
      cartItems.fold(0, (previousValue, item) => previousValue + item.price);

  // void addToCart(ItemModel item) {
  //   cartItems.add(item);
  // }
  bool isProductInCart(ItemModel product) {
    return cartItems.any((item) => item.id == product.id);
  }

  void addToCart(ItemModel product) {
    bool alreadyInCart = cartItems.any((item) => item.id == product.id);

    if (!alreadyInCart) {
      cartItems.add(product);
    } else {
      print('Product is already in the cart');
    }
  }

  // void removeFromCart(ItemModel item) {
  //   cartItems.remove(item);
  // }

  // void increment() => count.value++;
  // void decrement() => count.value--;

  void increaseQuantity(ItemModel product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
    }
  }

  void decreaseQuantity(ItemModel product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.remove(product);
    }
  }

  void updateQuantity(ItemModel product, int newQuantity) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else {
        cartItems.remove(product);
      }
    }
  }
}

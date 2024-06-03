import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/domain/DBHelper.dart';
import 'package:loyverspos/model/item_model.dart';

// class HomeController extends GetxController {
//   // var allItems = <ItemModel>[].obs;
//   RxList<ItemModel> allItems = RxList<ItemModel>([]);

//   final DatabaseHelper databaseHelper = DatabaseHelper();
//   final count = 0.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllItems();
//   }

//   // void fetchAllItems() async {
//   //   var items = await databaseHelper.getItems();
//   //   allItems.value = items;
//   // }
//   void fetchAllItems() async {
//     try {
//       var items = await databaseHelper.getItems();
//       allItems.value = items;
//     } catch (e) {
//       print('Error fetching items: $e');
//     }
//   }

//   var cartItems = <ItemModel>[].obs;

//   double get totalPrice =>
//       cartItems.fold(0, (previousValue, item) => previousValue + item.price);

//   // void addToCart(ItemModel item) {
//   //   cartItems.add(item);
//   // }
//   bool isProductInCart(ItemModel product) {
//     return cartItems.any((item) => item.id == product.id);
//   }

//   void addToCart(ItemModel product) {
//     bool alreadyInCart = cartItems.any((item) => item.id == product.id);

//     if (!alreadyInCart) {
//       cartItems.add(product);
//     } else {
//       print('Product is already in the cart');
//     }
//   }

//   // void removeFromCart(ItemModel item) {
//   //   cartItems.remove(item);
//   // }

//   // void increment() => count.value++;
//   // void decrement() => count.value--;

//   void increaseQuantity(ItemModel product) {
//     final index = cartItems.indexWhere((item) => item.id == product.id);
//     if (index != -1) {
//       cartItems[index].quantity++;
//     }
//   }

//   void decreaseQuantity(ItemModel product) {
//     final index = cartItems.indexWhere((item) => item.id == product.id);
//     if (index != -1 && cartItems[index].quantity > 1) {
//       cartItems[index].quantity--;
//     } else {
//       cartItems.remove(product);
//     }
//   }

//   void updateQuantity(ItemModel product, int newQuantity) {
//     final index = cartItems.indexWhere((item) => item.id == product.id);
//     if (index != -1) {
//       if (newQuantity > 0) {
//         cartItems[index].quantity = newQuantity;
//       } else {
//         cartItems.remove(product);
//       }
//     }
//   }

//   double updateprice(
//     ItemModel product,
//   ) {
//     final index = cartItems.indexWhere((item) => item.id == product.id);
//     var result;
//     if (index != -1) {
//       result = cartItems[index].price * cartItems[index].quantity;
//       return result;
//     } else {
//       return 0.0;
//     }
//   }
// }

class HomeController extends GetxController {
  RxList<ItemModel> allItems = RxList<ItemModel>([]);
  var cartItems = <ItemModel>[].obs;
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  void fetchAllItems() async {
    try {
      var items = await databaseHelper.getItems();
      allItems.value = items;
    } catch (e) {
      print('Error fetching items: $e'); // Consider using a logging package
    }
  }

  double get totalPrice => cartItems.fold(
      0, (previousValue, item) => previousValue + item.price * item.quantity);

  bool isProductInCart(ItemModel product) {
    return cartItems.any((item) => item.id == product.id);
  }

  void addToCart(ItemModel product, {int quantity = 1}) {
    if (!isProductInCart(product)) {
      product.quantity = quantity;
      cartItems.add(product);
    } else {
      print(
          'Product is already in the cart'); // Consider using a logging package
    }
  }

  void increaseQuantity(ItemModel product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      cartItems[index].quantity++;
      updatePrice();
    }
  }

  void decreaseQuantity(ItemModel product) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
      updatePrice();
    }
  }

  void updateQuantity(ItemModel product, int newQuantity) {
    final index = cartItems.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else {
        cartItems.removeAt(index);
      }
      updatePrice();
    }
  }

  void updatePrice() {
    cartItems
        .refresh(); // This will trigger UI updates for all observers of cartItems
  }

  void clearCart() {
    cartItems.clear();
  }
}

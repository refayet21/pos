import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loyverspos/infrastructure/navigation/routes.dart';
import 'package:loyverspos/model/item_model.dart';

// class MatchingBarcodesPage extends StatelessWidget {
//   final List<ItemModel> matchingItems;

//   MatchingBarcodesPage(this.matchingItems);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Matching Items'),
//       ),
//       body: ListView.builder(
//         itemCount: matchingItems.length,
//         itemBuilder: (context, index) {
//           final item = matchingItems[index];
//           return ListTile(
//             title: Text(item.name),
//             subtitle: Text(
//                 'Barcode: ${item.barcode}, Price: \$${item.price.toStringAsFixed(2)}'),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';

class MatchingBarcodesPage extends StatelessWidget {
  final List<ItemModel> matchingItems;
  final HomeController cartController = Get.put(HomeController());

  MatchingBarcodesPage(this.matchingItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to cart'),
      ),
      body: ListView.builder(
        itemCount: matchingItems.length,
        itemBuilder: (context, index) {
          final item = matchingItems[index];
          bool isInCart = cartController.isProductInCart(item);
          return ListTile(
            title: Text(item.name),
            subtitle: Text(
              'Price: \₹${item.price.toStringAsFixed(2)}',
            ),
            trailing: IconButton(
              icon: Icon(
                isInCart ? Icons.shopping_bag : Icons.shopping_bag,
                color: Colors.green,
                size: 40.sp,
              ),
              onPressed: () {
                if (!isInCart) {
                  cartController.addToCart(item);
                } else {
                  // Optionally, handle removing from the cart
                  // cartController.removeFromCart(item);
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.SALES);
        },
        label: Obx(() => Text('Cart (${cartController.cartItems.length})')),
      ),
    );
  }
}

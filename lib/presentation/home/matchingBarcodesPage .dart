import 'package:flutter/material.dart';
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
import 'package:loyverspos/presentation/home/controllers/cartpage.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';

class MatchingBarcodesPage extends StatelessWidget {
  // final List<ItemModel> matchingItems;

  // MatchingBarcodesPage(this.matchingItems);

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Matching Items'),
  //       actions: [
  //         IconButton(
  //           icon: Icon(Icons.shopping_cart),
  //           onPressed: () {
  //             // Navigate to the cart page when the cart icon is tapped
  //             Get.toNamed('/cart');
  //           },
  //         ),
  //       ],
  //     ),
  //     body: ListView.builder(
  //       itemCount: matchingItems.length,
  //       itemBuilder: (context, index) {
  //         final item = matchingItems[index];
  //         return ListTile(
  //           title: Text(item.name),
  //           subtitle: Text(
  //               'Barcode: ${item.barcode}, Price: \$${item.price.toStringAsFixed(2)}'),
  //           trailing: IconButton(
  //             icon: Icon(Icons.add_shopping_cart),
  //             onPressed: () {
  //               // Add the current item to the cart
  //               addToCart(item);
  //             },
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // // Function to add an item to the cart
  // void addToCart(ItemModel item) {
  //   // Implement your cart logic here, like adding the item to a list or database
  //   // For demonstration, let's print the item name
  //   print('Added to cart: ${item.name}');
  //   // You can also show a snackbar or toast to indicate the item is added to the cart
  //   Get.snackbar(
  //     'Added to Cart',
  //     '${item.name} added to your cart!',
  //     snackPosition: SnackPosition.BOTTOM,
  //     duration: Duration(seconds: 2),
  //   );
  // }

  final List<ItemModel> matchingItems;
  final HomeController cartController = Get.put(HomeController());

  MatchingBarcodesPage(this.matchingItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart page when the cart icon is tapped
              Get.toNamed(Routes.RECEIPTS);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: matchingItems.length,
        itemBuilder: (context, index) {
          final item = matchingItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(
                'Barcode: ${item.barcode}, Price: \$${item.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                // Add the current item to the cart
                cartController.addToCart(item);
              },
            ),
          );
        },
      ),
    );
  }
}

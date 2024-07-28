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
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: ListView.builder(
              itemCount: matchingItems.length,
              itemBuilder: (context, index) {
                final item = matchingItems[index];

                return Obx(() {
                  bool isInCart = cartController.isProductInCart(item);
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Price: \₹${item.price.toStringAsFixed(2)}',
                        ),
                        Obx(
                          () => Text(
                              'Total: \₹ ${(item.price * item.newQuantity.toInt()).toStringAsFixed(2)}'),
                        )
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // setState(() {
                            cartController.decreaseQuantity(item);
                            // _quantityController.text =
                            //     item.quantity.toString();
                            // });
                          },
                        ),
                        SizedBox(
                          width: 40.w,
                          // child: TextFormField(
                          //   // controller: _quantityController,
                          //   keyboardType: TextInputType.number,
                          //   textAlign: TextAlign.center,
                          //   onChanged: (newValue) {
                          //     try {
                          //       int newQuantity = int.parse(newValue);
                          //       cartController.updateQuantity(item, newQuantity);
                          //     } catch (e) {
                          //       // handle error if newValue is not a valid integer
                          //     }
                          //   },
                          // ),
                          child: Obx(
                            () => SizedBox(
                              width: 40,
                              child: Center(
                                  child: Text('${item.newQuantity.value}')),
                            ),
                          ),
                          // child: Obx(() => Text('${item.newQuantity}')),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            // setState(() {
                            cartController.increaseQuantity(item);
                            // _quantityController.text =
                            //     item.quantity.toString();
                            // });
                          },
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        IconButton(
                          icon: Icon(
                            isInCart
                                ? Icons.shopping_bag
                                : Icons.shopping_bag_outlined,
                            color: Colors.blue,
                            size: 40.sp,
                          ),
                          // onPressed: () {
                          //   if (!isInCart) {
                          //     cartController.addToCart(item);
                          //   } else {
                          //     // Optionally, handle removing from the cart
                          //     // cartController.removeFromCart(item);
                          //   }
                          // },

                          onPressed: () {
                            if (isInCart) {
                              cartController.removeFromCart(item);
                            } else {
                              cartController.addToCart(item);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.SALES);
                    },
                    child: Obx(
                      () => Text(
                        'CHARGE: \₹ ${cartController.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Obx(() => Text(
                        'CART ITEM (${cartController.cartItems.length})',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/receipts.controller.dart';

class ReceiptsScreen extends GetView<ReceiptsController> {
  ReceiptsScreen({Key? key}) : super(key: key);
  final HomeController cartController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  TextEditingController _quantityController =
                      TextEditingController(
                          text: cartController.cartItems[index].quantity
                              .toString());
                  final item = cartController.cartItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                    // trailing: Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     IconButton(
                    //       icon: Icon(Icons.remove),
                    //       onPressed: () {
                    //         cartController
                    //             .decreaseQuantity(
                    //             cartController.cartItems[index]);
                    //         // _quantityController.text =
                    //         //     cartController
                    //         //     .cartItems[index].quantity.toString();
                    //       },
                    //     ),
                    //     Obx(
                    //       () => Text('${cartController.count.value}'),
                    //     ), // Quantity (can be replaced with actual quantity)
                    //     IconButton(
                    //       icon: Icon(Icons.add),
                    //       onPressed: () {
                    //         cartController.increment;
                    //       },
                    //     ),
                    //   ],
                    // ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            cartController.decreaseQuantity(
                                cartController.cartItems[index]);
                            _quantityController.text = cartController
                                .cartItems[index].quantity
                                .toString();
                          },
                        ),
                        SizedBox(
                          width: 15.w, // Adjust the width as needed
                          child: TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (newValue) {
                              // Update the quantity when the user changes the value
                              cartController.updateQuantity(
                                  cartController.cartItems[index],
                                  int.parse(newValue));
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            cartController.increaseQuantity(
                                cartController.cartItems[index]);
                            _quantityController.text = cartController
                                .cartItems[index].quantity
                                .toString();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Total Price: \$${cartController.totalPrice.toStringAsFixed(2)}',
          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';

class CartPage extends StatelessWidget {
  final HomeController cartController = Get.find();

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
                  final item = cartController.cartItems[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            // Remove the item from the cart
                            cartController.removeFromCart(item);
                          },
                        ),
                        Text(
                            '1'), // Quantity (can be replaced with actual quantity)
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            // Add functionality to increase quantity
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Price: \$${cartController.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

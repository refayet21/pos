import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/receipts.controller.dart';

// class ReceiptsScreen extends GetView<ReceiptsController> {
//   ReceiptsScreen({Key? key}) : super(key: key);
//   final HomeController cartController = Get.put(HomeController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 itemCount: cartController.cartItems.length,
//                 itemBuilder: (context, index) {
//                   TextEditingController _quantityController =
//                       TextEditingController(
//                           text: cartController.cartItems[index].quantity
//                               .toString());
//                   final item = cartController.cartItems[index];
//                   return ListTile(
//                     title: Text(item.name),
//                     subtitle: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Price: \$${item.price.toStringAsFixed(2)}'),
//                         SizedBox(
//                           // width: 15.w, // Adjust the width as needed
//                           child: TextFormField(
//                             // controller: _quantityController,
//                             // keyboardType: TextInputType.number,
//                             readOnly: true,
//                             textAlign: TextAlign.center,
//                             onChanged: (newValue) {
//                               // Update the quantity when the user changes the value
//                               cartController.updateprice(
//                                 cartController.cartItems[index],
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     // trailing: Row(
//                     //   mainAxisSize: MainAxisSize.min,
//                     //   children: [
//                     //     IconButton(
//                     //       icon: Icon(Icons.remove),
//                     //       onPressed: () {
//                     //         cartController
//                     //             .decreaseQuantity(
//                     //             cartController.cartItems[index]);
//                     //         // _quantityController.text =
//                     //         //     cartController
//                     //         //     .cartItems[index].quantity.toString();
//                     //       },
//                     //     ),
//                     //     Obx(
//                     //       () => Text('${cartController.count.value}'),
//                     //     ), // Quantity (can be replaced with actual quantity)
//                     //     IconButton(
//                     //       icon: Icon(Icons.add),
//                     //       onPressed: () {
//                     //         cartController.increment;
//                     //       },
//                     //     ),
//                     //   ],
//                     // ),

//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.remove),
//                           onPressed: () {
//                             cartController.decreaseQuantity(
//                                 cartController.cartItems[index]);
//                             _quantityController.text = cartController
//                                 .cartItems[index].quantity
//                                 .toString();
//                           },
//                         ),
//                         SizedBox(
//                           width: 15.w, // Adjust the width as needed
//                           child: TextFormField(
//                             controller: _quantityController,
//                             keyboardType: TextInputType.number,
//                             textAlign: TextAlign.center,
//                             onChanged: (newValue) {
//                               // Update the quantity when the user changes the value
//                               cartController.updateQuantity(
//                                   cartController.cartItems[index],
//                                   int.parse(newValue));
//                             },
//                           ),
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.add),
//                           onPressed: () {
//                             cartController.increaseQuantity(
//                                 cartController.cartItems[index]);
//                             _quantityController.text = cartController
//                                 .cartItems[index].quantity
//                                 .toString();
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           // Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: Text(
//           //     'Total Price: \$${cartController.totalPrice.toStringAsFixed(2)}',
//           //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           //   ),
//           // ),

//           ElevatedButton(
//             onPressed: () async {
//               // Create a list to hold purchaseInfo data for each item
//               List<String> purchaseInfoList = [];

//               // Add vendor and date information
//               // String vendorInfo =
//               //     'Vendor Name: ${selectedVendor?.name ?? "N/A"}';
//               // String dateInfo = 'Date: ${dateController.text}';
//               // purchaseInfoList.add('$vendorInfo\n$dateInfo\n');

//               // Add cart items information
//               for (var index = 0;
//                   index < cartController.cartItems.length;
//                   index++) {
//                 var item = cartController.cartItems[index];

//                 String itemInfo = '';
//                 itemInfo += 'Product Name: ${item.name ?? "N/A"}\n';
//                 itemInfo += 'Barcode: ${item.barcode ?? "N/A"}\n';
//                 itemInfo += 'Price: ${item.price?.toString() ?? "N/A"}\n';
//                 // itemInfo += 'Stock: ${item.stock?.toString() ?? "N/A"}\n';
//                 // itemInfo +=
//                 //     'New Stock: ${(item.stock! + item.quantity).toString()}\n';
//                 itemInfo += '---\n'; // Separator between items, for clarity

//                 // Add the purchaseInfo data to the list
//                 purchaseInfoList.add(itemInfo);
//               }

//               // Show a dialog with the previous purchase information
//               await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Previous Purchase Information'),
//                     content: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children:
//                             purchaseInfoList.map((info) => Text(info)).toList(),
//                       ),
//                     ),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () async {
//                           // Continue with the purchase confirmation using updated cart items
//                           // await cartController.addPurchaseData(
//                           //   vendorDocId: selectedVendor!.docId,
//                           //   date: dateController.text,
//                           //   cartItems: controller.cartItems
//                           //       .map((item) => item.toJson())
//                           //       .toList(),
//                           // );

//                           // Close the dialog
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Confirm'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Close the dialog without saving
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Cancel'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text('Confirm Purchase'),
//           )
//         ],
//       ),
//     );
//   }
// }

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
                  final item = cartController.cartItems[index];
                  TextEditingController _quantityController =
                      TextEditingController(text: item.quantity.toString());

                  return ListTile(
                    title: Text('${item.name} ${item.barcode}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Price: \₹ ${item.price.toStringAsFixed(2)} × ${_quantityController.text}'),
                        // SizedBox(
                        //   width: 50.w,
                        //   child: TextFormField(
                        //     readOnly: true,
                        //     textAlign: TextAlign.center,
                        //     controller: _quantityController,
                        //   ),
                        // ),
                        // Obx(() => Text(
                        //     'Total: \$${(item.price * item.quantity).toStringAsFixed(2)}')),

                        Text(
                            'Total: \₹ ${(item.price * item.quantity).toStringAsFixed(2)}')
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            cartController.decreaseQuantity(item);
                            _quantityController.text = item.quantity.toString();
                          },
                        ),
                        SizedBox(
                          width: 50.w,
                          child: TextFormField(
                            controller: _quantityController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (newValue) {
                              try {
                                int newQuantity = int.parse(newValue);
                                cartController.updateQuantity(
                                    item, newQuantity);
                              } catch (e) {
                                // handle error if newValue is not a valid integer
                              }
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            cartController.increaseQuantity(item);
                            _quantityController.text = item.quantity.toString();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Price: \₹ ${cartController.totalPrice.toStringAsFixed(2)}',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              )),
          ElevatedButton(
            onPressed: () async {
              List<String> purchaseInfoList = [];

              for (var item in cartController.cartItems) {
                String itemInfo = '''
                  Product Name: ${item.name}
                  Barcode: ${item.barcode}
                  Price: \$${item.price}
                  Quantity: ${item.quantity}
                  Total: \$${(item.price * item.quantity).toStringAsFixed(2)}
                ''';
                purchaseInfoList.add(itemInfo);
              }

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Previous Purchase Information'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            purchaseInfoList.map((info) => Text(info)).toList(),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Confirm'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Confirm Purchase'),
          ),
        ],
      ),
    );
  }
}

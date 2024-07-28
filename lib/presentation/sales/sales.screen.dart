import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';

import 'package:get_storage/get_storage.dart';
import 'package:loyverspos/presentation/sales/controllers/sales.controller.dart';

class SalesScreen extends StatefulWidget {
  SalesScreen({Key? key}) : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final HomeController cartController = Get.find<HomeController>();
  final SalesController controller = Get.put(SalesController());
  TextEditingController cashReceiveController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Cart'),
          ),
      // body: Column(
      //   children: [
      //     Expanded(
      //       child: Obx(
      //         () => ListView.builder(
      //           itemCount: cartController.cartItems.length,
      //           itemBuilder: (context, index) {
      //             final item = cartController.cartItems[index];
      //             // TextEditingController _quantityController =
      //             //     TextEditingController(text: item.quantity.toString());

      //             return ListTile(
      //               title: Text('${item.name}-${item.barcode}'),
      //               subtitle: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                       'Price: \₹ ${item.price.toStringAsFixed(2)} × ${item.newQuantity}'),
      //                   Text(
      //                       'Total: \₹ ${(item.price * item.newQuantity.toInt()).toStringAsFixed(2)}')
      //                 ],
      //               ),
      //               // trailing: Row(
      //               //   mainAxisSize: MainAxisSize.min,
      //               //   children: [
      //               //     IconButton(
      //               //       icon: Icon(Icons.remove),
      //               //       onPressed: () {
      //               //         setState(() {
      //               //           // cartController.decreaseQuantity(item);
      //               //           _quantityController.text =
      //               //               item.quantity.toString();
      //               //         });
      //               //       },
      //               //     ),
      //               //     SizedBox(
      //               //       width: 50,
      //               //       child: TextFormField(
      //               //         controller: _quantityController,
      //               //         keyboardType: TextInputType.number,
      //               //         textAlign: TextAlign.center,
      //               //         onChanged: (newValue) {
      //               //           try {
      //               //             int newQuantity = int.parse(newValue);
      //               //             // cartController.updateQuantity(
      //               //             //     item, newQuantity);
      //               //           } catch (e) {
      //               //             // handle error if newValue is not a valid integer
      //               //           }
      //               //         },
      //               //       ),
      //               //     ),
      //               //     IconButton(
      //               //       icon: Icon(Icons.add),
      //               //       onPressed: () {
      //               //         setState(() {
      //               //           // cartController.increaseQuantity(item);
      //               //           _quantityController.text =
      //               //               item.quantity.toString();
      //               //         });
      //               //       },
      //               //     ),
      //               //   ],
      //               // ),
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //     Obx(() => Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Text(
      //             'Total Price: \₹ ${cartController.totalPrice.toStringAsFixed(2)}',
      //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //           ),
      //         )),
      //     ElevatedButton(
      //       onPressed: () async {
      //         await _showPreviewDialog(context);
      //       },
      //       child: Text('Preview'),
      //     ),
      //   ],
      // ),

      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(10.h),
                child: Center(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          '\₹ ${cartController.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 40.sp, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Total amount due ',
                          style: TextStyle(
                              fontSize: 11.sp, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          // Expanded(
          //     flex: 2,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           'Cash Received',
          //           style:
          //               TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          //         ),
          //         TextField(
          //           controller: cashReceiveController,
          //         )
          //       ],
          //     )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.money_sharp),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Cash',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.credit_card),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Card',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Future<void> _showPreviewDialog(BuildContext context) async {
    List<List<dynamic>> purchaseInfoList = [];
    List<List<dynamic>> purchaseInfofinalList = [];

    for (var item in cartController.cartItems) {
      List<dynamic> itemInfo = [
        'Product: ${item.name}-${item.barcode}',
        'Price: \₹${item.price}',
        'Quantity: ${item.newQuantity}',
        'Total: \₹${(item.price * item.newQuantity.toInt()).toStringAsFixed(2)}',
        '-------------'
      ];
      purchaseInfoList.add(itemInfo);
    }

    for (var item in cartController.cartItems) {
      List<dynamic> itemInfo = [
        '${item.name}-${item.barcode}',
        '${item.price}',
        '${item.newQuantity}',
        '${(item.price * item.newQuantity.toInt()).toStringAsFixed(2)}',
      ];
      purchaseInfofinalList.add(itemInfo);
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Preview Info'),
          content: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...purchaseInfoList.map((info) {
                    String itemInfo = info.join('\n');
                    return Text(itemInfo);
                  }).toList(),
                  Text(
                    'Total Price: \₹ ${cartController.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ]),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await _saveReceipt(context, purchaseInfofinalList);
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
  }

  Future<void> _saveReceipt(
      BuildContext context, List<List<dynamic>> purchaseInfofinalList) async {
    final box = GetStorage();
    String currentDates = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Retrieve the stored date and docounter value from local storage
    String? storedDate = box.read('storedDate');
    int docounter = box.read('docounter') ?? 0;

    // Check if the stored date matches the current date
    if (storedDate != currentDates) {
      // Reset the counter to 1
      docounter = 0;
      // Update the stored date to the current date
      await box.write('storedDate', currentDates);
    } else {
      // Increment the counter if the stored date matches the current date
      docounter++;
    }

    // Save the updated docounter value to local storage
    await box.write('docounter', docounter);

    docounter++;

    final String currentDate = DateTime.now().day.toString().padLeft(2, '0');
    final String currentMonth = DateTime.now().month.toString().padLeft(2, '0');
    final String currentYear = DateTime.now().year.toString();

    final String InvNo =
        'Inv-$currentDate-$currentMonth-$currentYear-$docounter';

    controller.saveReceipts(ReceiptsModel(
      receiptNo: InvNo,
      date: '$currentDate-$currentMonth-$currentYear',
      data: purchaseInfofinalList,
      totalPrice: cartController.totalPrice.toStringAsFixed(2),
    ));

    Navigator.of(context).pop();
    cartController.clearCart();
  }
}

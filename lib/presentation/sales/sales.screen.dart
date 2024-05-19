import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';
import 'package:loyverspos/widgets/drawer.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/sales.controller.dart';

class SalesScreen extends GetView<SalesController> {
  SalesScreen({Key? key}) : super(key: key);

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
                    title: Text('${item.name}-${item.barcode}'),
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
                String itemInfo =
                    '''
                  Product: ${item.name}-${item.barcode}
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
                    title: Text('Preview Info'),
                    content: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...purchaseInfoList
                                .map((info) => Text(info))
                                .toList(),
                            Text(
                              'Total Price: \₹ ${cartController.totalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          final box = GetStorage();
                          String currentDates =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());

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

                          final String currentDate =
                              DateTime.now().day.toString().padLeft(2, '0');
                          final String currentMonth =
                              DateTime.now().month.toString().padLeft(2, '0');
                          final String currentYear =
                              DateTime.now().year.toString();

                          final String InvNo =
                              'Inv-$currentDate-$currentMonth-$currentYear-$docounter';

                          controller.saveReceipts(ReceiptsModel(
                            receiptNo: InvNo,
                            // date: (DateFormat("dd/MM/yyyy")
                            //     .format(DateTime.now() as DateTime)
                            //     .toString()),
                            date: '$currentDate-$currentMonth-$currentYear',
                            data: purchaseInfoList,
                            totalPrice:
                                cartController.totalPrice.toStringAsFixed(2),
                          ));
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

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loyverspos/model/receiptsModel.dart';
import 'package:loyverspos/widgets/drawer.dart';
import 'controllers/receipts.controller.dart';

class ReceiptsScreen extends GetView<ReceiptsController> {
  ReceiptsScreen({Key? key}) : super(key: key) {
    Get.put(ReceiptsController());
  }
  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'All Receipts',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: controller.receipts.length,
            itemBuilder: (context, index) {
              List<dynamic> data = controller.receipts[index]['data'];

              List<List<dynamic>> convertedList = [];
              for (var item in data) {
                List<dynamic> items = item['items'];
                convertedList.add(items);
              }

              return Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Card(
                  child: ListTile(
                    title: Text(
                      'Receipt No: ${controller.receipts[index]['receiptNo']}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${controller.receipts[index]['date']}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Total Price: ${controller.receipts[index]['totalPrice']}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.print,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _printReceipt(
                            controller.receipts[index]['receiptNo'],
                            controller.receipts[index]['date'],
                            convertedList,
                            controller.receipts[index]['totalPrice']);
                        // print(convertedList);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _printReceipt(String receiptNo, String date,
      List<List<dynamic>> data, String totalPrice) async {
    // Check if the Bluetooth is connected
    if ((await bluetooth.isConnected) == true) {
      bluetooth.printCustom("Receipt No: $receiptNo", 3, 1);
      bluetooth.printCustom("Date: $date", 1, 1);
      // Print each item in the receipt data
      for (var item in data) {
        bluetooth.printCustom("Product: ${item[0]}", 1,
            1); // Assuming item[0] is the product name
        bluetooth.printCustom(
            "Price: ${item[1]}", 1, 1); // Assuming item[1] is the price
        bluetooth.printCustom(
            "Quantity: ${item[2]}", 1, 1); // Assuming item[2] is the quantity
        bluetooth.printCustom(
            "Total: ${item[3]}", 1, 1); // Assuming item[3] is the total
      }
      bluetooth.printCustom("Total Price: $totalPrice", 1, 1);
      bluetooth.printNewLine();
      bluetooth.printNewLine();
      bluetooth.paperCut();
    } else {
      // Connect to the Bluetooth printer
      List<BluetoothDevice> devices = await bluetooth.getBondedDevices();
      // Assuming you have one device, otherwise prompt the user to select a device
      if (devices.isNotEmpty) {
        await bluetooth.connect(devices.first);
        _printReceipt(receiptNo, date, data,
            totalPrice); // Retry printing after connection
      } else {
        Get.snackbar("Error", "No Bluetooth devices found");
      }
    }
  }
}

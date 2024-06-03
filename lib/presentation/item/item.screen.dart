import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/item.controller.dart';

class ItemScreen extends GetView<ItemController> {
  ItemScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  int? studentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(title: Text('Items')),
      body: Obx(() {
        // return ListView.builder(
        //   itemCount: controller.allItems.length,
        //   itemBuilder: (context, index) {
        //     final item = controller.allItems[index];
        //     return ListTile(
        //       title: Text(item.name),
        //       subtitle: Text('Barcode: ${item.barcode} | Price: ${item.price}'),
        //       trailing: IconButton(
        //         icon: Icon(
        //           Icons.delete,
        //           color: Colors.red, // Set the color to red
        //         ),
        //         onPressed: () => controller.deleteItem(item.id!),
        //       ),
        //       onTap: () => _showItemDialog(context, item),
        //     );
        //   },
        // );

        return ListView.builder(
          itemCount: controller.allItems.length,
          itemBuilder: (context, index) {
            final item = controller.allItems[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                title: Text(
                  item.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  'Barcode: ${item.barcode} | Price: ${item.price}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                // trailing: IconButton(
                //   icon: Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //   ),
                //   onPressed: () => controller.deleteItem(item.id!),
                // ),
                // onTap: () => _showItemDialog(context, item),

                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_note,
                        color: Colors.blue,
                      ),
                      onPressed: () => _showItemDialog(context, item),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => controller.deleteItem(item.id!),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showItemDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showItemDialog(BuildContext context, [ItemModel? item]) {
    final isNewItem = item == null;
    final nameController = TextEditingController(text: item?.name ?? '');
    final barcodeController = TextEditingController(text: item?.barcode ?? '');
    final priceController =
        TextEditingController(text: item?.price.toString() ?? '');

    Get.defaultDialog(
      title: isNewItem ? 'Add Item' : 'Update Item',
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: barcodeController,
            decoration: InputDecoration(labelText: 'Barcode'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textConfirm: isNewItem ? 'Save' : 'Update',
      onConfirm: () {
        final name = nameController.text;
        final barcode = barcodeController.text;
        final price = double.tryParse(priceController.text) ?? 0.0;

        if (name.isNotEmpty && barcode.isNotEmpty && price > 0) {
          final newItem = ItemModel(
            id: item?.id,
            name: name,
            barcode: barcode,
            price: price,
          );

          if (isNewItem) {
            controller.addItem(newItem);
          } else {
            controller.updateItem(newItem);
          }

          Get.back();
        }
      },
    );
  }
}

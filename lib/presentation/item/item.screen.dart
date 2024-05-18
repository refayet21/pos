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
        return ListView.builder(
          itemCount: controller.allItems.length,
          itemBuilder: (context, index) {
            final item = controller.allItems[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text('Barcode: ${item.barcode} | Price: ${item.price}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => controller.deleteItem(item.id!),
              ),
              onTap: () => _showItemDialog(context, item),
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

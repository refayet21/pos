import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/item.controller.dart';

class ItemScreen extends GetView<ItemController> {
  const ItemScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'Add Item',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: TextField(
              onChanged: (value) => controller.searchItem(value),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          // Expanded(
          //   child: Obx(
          //     () => ListView.builder(
          //       itemCount: controller.foundItem.length,
          //       itemBuilder: (context, index) => Card(
          //         color: Colors.grey.shade200,
          //         child: ListTile(
          //           title: Text(
          //             'Name : ${controller.foundItem[index].name!}',
          //             style: TextStyle(
          //                 fontSize: 16.sp,
          //                 fontWeight: FontWeight.w600,
          //                 color: Colors.black),
          //           ),
          //           subtitle: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               SizedBox(
          //                 height: 7.h,
          //               ),
          //               Text(
          //                 'category : ${controller.foundItem[index].category!}',
          //                 style: TextStyle(
          //                     fontSize: 14.sp,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.black),
          //               ),
          //               SizedBox(
          //                 height: 7.h,
          //               ),
          //               Text(
          //                 'Checkin : ${controller.foundItem[index].checkin!}',
          //                 style: TextStyle(
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w600,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //               SizedBox(height: 7.h),
          //               Text(
          //                 'Checkout : ${controller.foundItem[index].checkout!}',
          //                 style: TextStyle(
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w600,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //               SizedBox(height: 7.h),
          //               Text(
          //                 'Booked : ${controller.foundItem[index].booked!}',
          //                 style: TextStyle(
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w600,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           leading: CircleAvatar(
          //             child: Text(
          //               controller.foundItem[index].name!
          //                   .substring(0, 1)
          //                   .capitalize!,
          //               style: TextStyle(
          //                   fontWeight: FontWeight.w700, color: Colors.black),
          //             ),
          //             backgroundColor: Colors.blue.shade200,
          //           ),
          //           trailing: IconButton(
          //             icon: Icon(
          //               Icons.delete_forever,
          //               color: Colors.red,
          //             ),
          //             onPressed: () {
          //               displayDeleteDialog(
          //                   controller.foundItem[index].docId!);
          //             },
          //           ),
          //           onTap: () {
          //             controller.nameController.text =
          //                 controller.foundItem[index].name!;
          //             controller.categoryController.text =
          //                 controller.foundItem[index].category!;

          //             controller.checkinController.text =
          //                 controller.foundItem[index].checkin!.toString();
          //             controller.checkoutController.text =
          //                 controller.foundItem[index].checkout!.toString();
          //             controller.bookedController.text =
          //                 controller.foundItem[index].booked!.toString();
          //             _buildAddEditItemView(
          //                 text: 'UPDATE',
          //                 addEditFlag: 2,
          //                 docId: controller.foundItem[index].docId!);
          //           },
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Expanded(
            child: Obx(
              () {
                // Group Items by category
                Map<String, List<ItemModel>> groupedItems = {};
                for (var item in controller.findItem) {
                  if (!groupedItems.containsKey(item.category)) {
                    groupedItems[item.category!] = [];
                  }
                  groupedItems[item.category!]!.add(item);
                }

                // Sort groupedItems by category
                var sortedEntries = groupedItems.entries.toList()
                  ..sort((a, b) => a.key.compareTo(b.key));
                // var category;
                // var Items;

                return ListView.builder(
                  itemCount: sortedEntries.length,
                  itemBuilder: (context, categoryIndex) {
                    var category = sortedEntries[categoryIndex].key;
                    var items = sortedEntries[categoryIndex].value;

                    // Sort Items by name
                    items.sort((a, b) => a.name!.compareTo(b.name!));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.blue.shade200,
                              child: ListTile(
                                title: Text(
                                  'Name: ${items[index].name ?? "N/A"}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5.h),
                                    Text(
                                        'soldBy: ${items[index].soldBy ?? "N/A"}'),
                                    Text(
                                        'price: ${items[index].price ?? "N/A"}'),
                                    Text('cost: ${items[index].cost ?? "N/A"}'),
                                    Text(
                                        'barcode: ${items[index].barcode ?? "N/A"}'),
                                    Text(
                                        'stock: ${items[index].stock ?? "N/A"}'),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    displayDeleteDialog(items[index].docId!);
                                  },
                                ),
                                onTap: () {
                                  controller.nameController.text =
                                      items[index].name!;
                                  controller.categoryController.text =
                                      items[index].category!;

                                  controller.soldByController.text =
                                      items[index].soldBy!.toString();
                                  controller.priceController.text =
                                      items[index].price!.toString();
                                  controller.costController.text =
                                      items[index].cost!.toString();
                                  controller.barcodeController.text =
                                      items[index].barcode!.toString();
                                  controller.stockController.text =
                                      items[index].stock!.toString();
                                  _buildAddEditItemView(
                                      text: 'UPDATE',
                                      addEditFlag: 2,
                                      docId: items[index].docId!);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            _buildAddEditItemView(text: 'ADD', addEditFlag: 1, docId: '');
          },
          child: Text('Add Item')),
    );
  }

  _buildAddEditItemView({String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.r),
              topLeft: Radius.circular(16.r),
            ),
            color: Colors.blue.shade200),
        child: Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 16.h),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${text} Item',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.nameController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.categoryController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'soldBy',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.soldByController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'price',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.priceController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'cost',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.costController,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'barcode',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.barcodeController,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'stock',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.stockController,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: Get.context!.width, height: 45.h),
                    child: ElevatedButton(
                      child: Text(
                        text!,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      onPressed: () {
                        final itemModel = ItemModel(
                          docId: docId,
                          name: controller.nameController.text,
                          category: controller.categoryController.text,
                          soldBy: controller.soldByController.text,
                          price: int.tryParse(controller.priceController.text),
                          cost: int.tryParse(controller.costController.text),
                          barcode: controller.barcodeController.text,
                          stock: int.tryParse(controller.stockController.text),
                        );

                        controller.saveUpdateItem(
                            itemModel, docId!, addEditFlag!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //  _buildAddEditProductView({String? text, int? addEditFlag, String? docId}) {
  //   Get.bottomSheet(
  //     Container(
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(16.r),
  //             topLeft: Radius.circular(16.r),
  //           ),
  //           color: Colors.blue.shade200),
  //       child: Padding(
  //         padding:
  //             EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 16.h),
  //         child: Form(
  //           key: controller.formKey,
  //           autovalidateMode: AutovalidateMode.onUserInteraction,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   '${text} Item',
  //                   style: TextStyle(
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black),
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.text,
  //                   decoration: InputDecoration(
  //                     hintText: 'Name',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.nameController,
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.text,
  //                   decoration: InputDecoration(
  //                     hintText: 'category',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.categoryController,
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.number,
  //                   decoration: InputDecoration(
  //                     hintText: 'soldBy',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.soldByController,
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.number,
  //                   decoration: InputDecoration(
  //                     hintText: 'price',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.priceController,
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.number,
  //                   decoration: InputDecoration(
  //                     hintText: 'cost',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.costController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.number,
  //                   decoration: InputDecoration(
  //                     hintText: 'barcode',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.barcodeController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.number,
  //                   decoration: InputDecoration(
  //                     hintText: 'Stock',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.stockController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 ConstrainedBox(
  //                   constraints: BoxConstraints.tightFor(
  //                       width: Get.context!.width, height: 45.h),
  //                   child: ElevatedButton(
  //                     child: Text(
  //                       text!,
  //                       style: TextStyle(color: Colors.black, fontSize: 16.sp),
  //                     ),
  //                     onPressed: () {
  //                       final productModel = ItemModel(
  //                         docId: docId,
  //                         name: controller.nameController.text,
  //                         category: controller.categoryController.text,
  //                         checkin:
  //                             int.tryParse(controller.checkinController.text),
  //                         checkout:
  //                             int.tryParse(controller.checkoutController.text),
  //                         booked:
  //                             int.tryParse(controller.bookedController.text),
  //                       );

  //                       controller.saveUpdateItem(
  //                           productModel, docId!, addEditFlag!);
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  displayDeleteDialog(String docId) {
    Get.defaultDialog(
      title: "Delete Item",
      titleStyle: TextStyle(fontSize: 20.sp),
      middleText: 'Are you sure to delete Product ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        controller.deleteData(docId);
      },
    );
  }
}

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
      appBar: AppBar(
        title: const Text('ItemScreen'),
        centerTitle: true,
      ),
      body: Obx(
        () => Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Enter name'),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     // ElevatedButton(

              //     //     child: Text("Add")),
              //     SizedBox(
              //       width: 16,
              //     ),
              //     // ElevatedButton(
              //     //     onPressed: () {
              //     //       if (nameController.text != "") {
              //     //         controller.updateStudent(ItemModel(
              //     //             id: studentId, name: nameController.text));
              //     //         nameController.text = "";
              //     //       }
              //     //     },
              //     //     child: Text("Update"))
              //   ],
              // ),
              Expanded(
                  child: ListView.builder(
                      itemCount: controller.allStudent.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(controller.allStudent[index].name!),
                          // onTap: () {
                          //   studentId = controller.allStudent[index].id!;
                          //   nameController.text =
                          //       controller.allStudent[index].name!;
                          // },
                          // child: Card(
                          //   child: Row(
                          //     children: <Widget>[
                          //       Expanded(
                          //         child: Container(
                          //           padding: EdgeInsets.all(16),
                          //           child: Text(
                          //               controller.allStudent[index].name!),
                          //         ),
                          //       ),
                          //       InkWell(
                          //           onTap: () {
                          //             controller.deleteStudent(
                          //                 controller.allStudent[index].id!);
                          //           },
                          //           child: Icon(
                          //             Icons.close,
                          //             color: Colors.red,
                          //             size: 32,
                          //           ))
                          //     ],
                          //   ),
                          // ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              displayDeleteDialog(
                                  controller.allStudent[index].id!);
                            },
                          ),

                          onTap: () {
                            studentId = controller.allStudent[index].id!;
                            nameController.text =
                                controller.allStudent[index].name!;
                          },
                        );
                      }))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (nameController.text != "") {
            controller
                .addStudent(ItemModel(id: null, name: nameController.text));
            nameController.text = "";
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  displayDeleteDialog(int id) {
    Get.defaultDialog(
      title: "Delete Item",
      titleStyle: TextStyle(fontSize: 20.sp),
      middleText: 'Are you sure to delete Product ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        controller.deleteStudent(id);
      },
    );
  }
}

  // _buildAddEditItemView({String? text, int? addEditFlag, String? docId}) {
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
  //                   // keyboardType: TextInputType.number,
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
  //                   // keyboardType: TextInputType.number,
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
  //                     hintText: 'stock',
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
  //                       final itemModel = ItemModel(
  //                         docId: docId,
  //                         name: controller.nameController.text,
  //                         category: controller.categoryController.text,
  //                         soldBy: controller.soldByController.text,
  //                         price: int.tryParse(controller.priceController.text),
  //                         cost: int.tryParse(controller.costController.text),
  //                         barcode: controller.barcodeController.text,
  //                         stock: int.tryParse(controller.stockController.text),
  //                       );

  //                       controller.saveUpdateItem(
  //                           itemModel, docId!, addEditFlag!);
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

 

  
// }

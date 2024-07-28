import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/adduser.controller.dart';

class AdduserScreen extends GetView<AdduserController> {
  const AdduserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'ADD USER',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: TextField(
              onChanged: (value) => controller.searchuser(value),
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
          //       itemCount: controller.founduser.length,
          //       itemBuilder: (context, index) => Card(
          //         color: Colors.grey.shade200,
          //         child: ListTile(
          //           title: Text(
          //             'Name : ${controller.founduser[index].name!}',
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
          //                 height: 3.h,
          //               ),
          //               Text(
          //                 'Address :${controller.founduser[index].address!}',
          //                 style: TextStyle(
          //                     fontSize: 14.sp,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.black),
          //               ),
          //               SizedBox(
          //                 height: 3.h,
          //               ),
          //               Text(
          //                 'Mobile : ${controller.founduser[index].mobile!}',
          //                 style: TextStyle(
          //                     fontSize: 14.sp,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.black),
          //               ),
          //               SizedBox(
          //                 height: 3.h,
          //               ),
          //               Text(
          //                 'Email : ${controller.founduser[index].email!}',
          //                 style: TextStyle(
          //                     fontSize: 14.sp,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.black),
          //               ),
          //               SizedBox(
          //                 height: 3.h,
          //               ),
          //               Text(
          //                 'Password : ${controller.founduser[index].password!}',
          //                 style: TextStyle(
          //                     fontSize: 14.sp,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.black),
          //               ),
          //             ],
          //           ),
          //           leading: CircleAvatar(
          //             child: Text(
          //               controller.founduser[index].name!
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
          //                   controller.founduser[index].docId!);
          //             },
          //           ),
          //           onTap: () {
          //             controller.nameController.text =
          //                 controller.founduser[index].name!;
          //             controller.addressController.text =
          //                 controller.founduser[index].address!;
          //             controller.mobileController.text =
          //                 controller.founduser[index].mobile!;
          //             controller.emailController.text =
          //                 controller.founduser[index].email!;
          //             controller.passwordController.text =
          //                 controller.founduser[index].password!;

          //             _buildAddEdituserView(
          //                 text: 'UPDATE',
          //                 addEditFlag: 2,
          //                 docId: controller.founduser[index].docId!);
          //           },
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Expanded(
            child: Obx(
              () {
                // Sort founduser list by name
                controller.founduser.sort((a, b) => a.name!.compareTo(b.name!));

                return ListView.builder(
                  itemCount: controller.founduser.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.grey.shade200,
                    child: ListTile(
                      title: Text(
                        'Name : ${controller.founduser[index].name!}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3.h),
                          Text(
                            'Address :${controller.founduser[index].address!}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Mobile : ${controller.founduser[index].mobile!}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Email : ${controller.founduser[index].email!}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Receipt Serial : ${controller.founduser[index].receiptSerial!}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      leading: CircleAvatar(
                        child: Text(
                          controller.founduser[index].name!
                              .substring(0, 1)
                              .capitalize!,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        backgroundColor: Colors.blue.shade200,
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          displayDeleteDialog(
                            controller.founduser[index].docId!,
                          );

                          // print(
                          //     ' view docid ${controller.founduser[index].docId!}');
                        },
                      ),
                      onTap: () {
                        controller.nameController.text =
                            controller.founduser[index].name!;
                        controller.addressController.text =
                            controller.founduser[index].address!;
                        controller.mobileController.text =
                            controller.founduser[index].mobile!;
                        controller.emailController.text =
                            controller.founduser[index].email!;
                        controller.passwordController.text =
                            controller.founduser[index].password!;

                        controller.receiptSerialController.text = controller
                            .founduser[index].receiptSerial
                            .toString();

                        _buildAddEdituserView(
                          text: 'UPDATE',
                          addEditFlag: 2,
                          docId: controller.founduser[index].docId!,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            _buildAddEdituserView(text: 'ADD', addEditFlag: 1, docId: '');
          },
          child: Text('ADD USER')),
    );
  }

  // _buildAddEdituserView({String? text, int? addEditFlag, String? docId}) {
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
  //                   '${text} Do User',
  //                   style: TextStyle(
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black),
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                     hintText: 'Name',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.nameController,
  //                   // validator: (value) {
  //                   //   return controller.validateName(value!);
  //                   // },
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'address',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.addressController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'Mobile',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.mobileController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   readOnly: addEditFlag == 2 ? true : false,
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'Email',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.emailController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   readOnly: addEditFlag == 2 ? true : false,
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'Password',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.passwordController,
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
  //                       controller.saveUpdateusers(
  //                         controller.nameController.text,
  //                         controller.addressController.text,
  //                         controller.mobileController.text,
  //                         controller.emailController.text,
  //                         controller.passwordController.text,
  //                         docId!,
  //                         addEditFlag!,
  //                       );
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

  _buildAddEdituserView({String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.blue.shade200,
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${text}User',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.addressController,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.mobileController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Mobile';
                      }
                      if (value.length < 11) {
                        return 'Mobile No must be  11 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    readOnly: addEditFlag == 2 ? true : false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    readOnly: addEditFlag == 2 ? true : false,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    readOnly: addEditFlag == 2 ? true : false,
                    keyboardType: TextInputType.number,
                    // obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'ReceiptSerial',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.receiptSerialController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ReceiptSerial';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: Get.context!.width,
                      height: 45.h,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        text!,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.saveUpdateusers(
                            controller.nameController.text,
                            controller.addressController.text,
                            controller.mobileController.text,
                            controller.emailController.text,
                            controller.passwordController.text,
                            int.tryParse(
                                controller.receiptSerialController.text),
                            docId!,
                            addEditFlag!,
                          );
                        }
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

  // displayDeleteDialog(String docId) {
  //   Get.defaultDialog(
  //     title: "Delete Do User",
  //     titleStyle: TextStyle(fontSize: 20.sp),
  //     middleText: 'Are you sure to delete Do User ?',
  //     textCancel: "Cancel",
  //     textConfirm: "Confirm",
  //     confirmTextColor: Colors.black,
  //     onCancel: () {},
  //     onConfirm: () {
  //       controller.deleteData(docId);
  //       print('dialog docId is $docId');
  //     },
  //   );
  // }

  void displayDeleteDialog(String docId) {
    Get.defaultDialog(
      title: "Delete User",
      titleStyle: TextStyle(fontSize: 20.sp),
      middleText: 'Are you sure to delete User ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        controller.deleteData(docId);
        Get.back();
      },
    );
  }
}

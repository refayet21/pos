import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/presentation/home/controllers/home.controller.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/receipts.controller.dart';

class ReceiptsScreen extends GetView<ReceiptsController> {
  ReceiptsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: const Text('ReceiptsScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReceiptsScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

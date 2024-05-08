import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/receipts.controller.dart';

class ReceiptsScreen extends GetView<ReceiptsController> {
  const ReceiptsScreen({Key? key}) : super(key: key);
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

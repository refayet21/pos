import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/sales.controller.dart';

class SalesScreen extends GetView<SalesController> {
  const SalesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: const Text('SalesScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SalesScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

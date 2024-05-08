import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/item.controller.dart';

class ItemScreen extends GetView<ItemController> {
  const ItemScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: const Text('ItemScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ItemScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/category.controller.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: const Text('CategoryScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CategoryScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

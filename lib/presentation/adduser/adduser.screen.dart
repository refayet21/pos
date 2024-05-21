import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/adduser.controller.dart';

class AdduserScreen extends GetView<AdduserController> {
  const AdduserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdduserScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdduserScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

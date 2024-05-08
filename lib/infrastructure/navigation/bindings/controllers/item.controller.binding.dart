import 'package:get/get.dart';

import '../../../../presentation/item/controllers/item.controller.dart';

class ItemControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(
      () => ItemController(),
    );
  }
}

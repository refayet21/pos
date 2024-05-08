import 'package:get/get.dart';

import '../../../../presentation/category/controllers/category.controller.dart';

class CategoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
  }
}

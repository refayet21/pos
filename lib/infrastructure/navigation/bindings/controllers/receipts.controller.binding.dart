import 'package:get/get.dart';

import '../../../../presentation/receipts/controllers/receipts.controller.dart';

class ReceiptsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptsController>(
      () => ReceiptsController(),
    );
  }
}

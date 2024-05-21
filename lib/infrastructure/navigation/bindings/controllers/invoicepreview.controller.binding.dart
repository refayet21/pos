import 'package:get/get.dart';

import '../../../../presentation/invoicepreview/controllers/invoicepreview.controller.dart';

class InvoicepreviewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoicepreviewController>(
      () => InvoicepreviewController(),
    );
  }
}

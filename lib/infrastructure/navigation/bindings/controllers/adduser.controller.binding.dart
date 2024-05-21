import 'package:get/get.dart';

import '../../../../presentation/adduser/controllers/adduser.controller.dart';

class AdduserControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdduserController>(
      () => AdduserController(),
    );
  }
}

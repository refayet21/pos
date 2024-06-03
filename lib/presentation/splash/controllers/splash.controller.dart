import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loyverspos/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  static const int splashDurationSeconds = 3;

  @override
  void onInit() {
    super.onInit();
    startDelayedFuture();
  }

  Future<void> startDelayedFuture() async {
    await Future.delayed(Duration(seconds: splashDurationSeconds));
    await checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    var adminemail = box.read('adminemail');
    var useremail = box.read('useremail');

    if (adminemail != null && adminemail.isNotEmpty) {
      Get.offNamed(Routes.HOME);
    } else if (useremail != null && useremail.isNotEmpty) {
      Get.offNamed(Routes.HOME);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}

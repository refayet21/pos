import 'package:get/get.dart';
import 'package:loyverspos/domain/DBHelper.dart';
import 'package:loyverspos/model/item_model.dart';

class HomeController extends GetxController {
  var allItems = <ItemModel>[].obs;
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchAllItems();
  }

  void fetchAllItems() async {
    var items = await databaseHelper.getItems();
    allItems.value = items;
  }
}

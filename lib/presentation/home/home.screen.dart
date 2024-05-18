import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/presentation/home/matchingBarcodesPage%20.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/home.controller.dart';

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: AdminDrawer(),
//       appBar: AppBar(title: Text('Home')),
//       body: Obx(() {
//         return ListView.builder(
//           itemCount: controller.allItems.length,
//           itemBuilder: (context, index) {
//             final item = controller.allItems[index];
//             return ListTile(
//               title: Text(item.barcode),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/widgets/drawer.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(title: Text('Home')),
      body: Obx(() {
        return ListView.builder(
          itemCount: controller.allItems.length,
          itemBuilder: (context, index) {
            final item = controller.allItems[index];
            // Check if the current item's barcode has the same first three characters as the previous item
            if (index == 0 ||
                item.barcode.substring(0, 3) !=
                    controller.allItems[index - 1].barcode.substring(0, 3)) {
              return ListTile(
                title: Text(item.barcode),
                onTap: () => _showMatchingBarcodesPage(item.barcode),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        );
      }),
    );
  }

  void _showMatchingBarcodesPage(String barcode) {
    String firstThreeCharacters = barcode.substring(0, 3);
    List<ItemModel> matchingItems = controller.allItems
        .where((item) => item.barcode.startsWith(firstThreeCharacters))
        .toList();

    Get.to(() => MatchingBarcodesPage(matchingItems));
  }
}

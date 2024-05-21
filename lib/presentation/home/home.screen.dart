import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loyverspos/model/item_model.dart';
import 'package:loyverspos/presentation/home/matchingBarcodesPage%20.dart';
import 'package:loyverspos/widgets/drawer.dart';

import 'controllers/home.controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loyverspos/widgets/drawer.dart';

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: AdminDrawer(),
//       appBar: AppBar(title: Text('SALE')),
//       body: Obx(() {
//         return ListView.builder(
//           itemCount: controller.allItems.length,
//           itemBuilder: (context, index) {
//             final item = controller.allItems[index];
//             // Check if the current item's barcode has the same first three characters as the previous item
//             if (index == 0 ||
//                 item.barcode.substring(0, 1) !=
//                     controller.allItems[index - 1].barcode.substring(0, 1)) {
//               return ListTile(
//                 title: Text(item.barcode),
//                 onTap: () => _showMatchingBarcodesPage(item.barcode),
//               );
//             } else {
//               return SizedBox.shrink();
//             }
//           },
//         );
//       }),
//     );
//   }

//   void _showMatchingBarcodesPage(String barcode) {
//     String firstOneCharacters = barcode.substring(0, 1);
//     List<ItemModel> matchingItems = controller.allItems
//         .where((item) => item.barcode.startsWith(firstOneCharacters))
//         .toList();

//     Get.to(() => MatchingBarcodesPage(matchingItems));
//   }
// }

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(title: Text('SALE')),
      body: Obx(() {
        // Get the unique groups based on the first two characters
        final uniqueGroups = _getUniqueGroups(controller.allItems);

        return ListView.builder(
          itemCount: uniqueGroups.length,
          itemBuilder: (context, index) {
            final group = uniqueGroups[index];
            return ListTile(
              title: Text(group),
              onTap: () => _showMatchingBarcodesPage(group),
            );
          },
        );
      }),
    );
  }

  List<String> _getUniqueGroups(List<ItemModel> items) {
    final Set<String> groups = {};
    for (var item in items) {
      if (item.barcode.length >= 2) {
        // Add the first two characters to the set
        groups.add(item.barcode.substring(0, 2));
      }
    }
    return groups.toList();
  }

  void _showMatchingBarcodesPage(String group) {
    List<ItemModel> matchingItems = controller.allItems
        .where((item) => item.barcode.startsWith(group))
        .toList();

    Get.to(() => MatchingBarcodesPage(matchingItems));
  }
}

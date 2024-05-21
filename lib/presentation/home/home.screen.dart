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

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: AdminDrawer(),
//       appBar: AppBar(title: Text('SALE')),
//       body: Obx(() {
//         // Get the unique groups based on the first two characters
//         final uniqueGroups = _getUniqueGroups(controller.allItems);

//         return ListView.builder(
//           itemCount: uniqueGroups.length,
//           itemBuilder: (context, index) {
//             final group = uniqueGroups[index];
//             return ListTile(
//               title: Text(group),
//               onTap: () => _showMatchingBarcodesPage(group),
//             );
//           },
//         );
//       }),
//     );
//   }

//   List<String> _getUniqueGroups(List<ItemModel> items) {
//     final Set<String> groups = {};
//     for (var item in items) {
//       if (item.barcode.length >= 2) {
//         // Add the first two characters to the set
//         groups.add(item.barcode.substring(0, 2));
//       }
//     }
//     return groups.toList();
//   }

//   void _showMatchingBarcodesPage(String group) {
//     List<ItemModel> matchingItems = controller.allItems
//         .where((item) => item.barcode.startsWith(group))
//         .toList();

//     Get.to(() => MatchingBarcodesPage(matchingItems));
//   }
// }

// class HomeScreen extends GetView<HomeController> {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: AdminDrawer(),
//       appBar: AppBar(title: Text('SALE')),
//       body: Obx(() {
//         final uniqueLengths = _getUniqueAlphabetLengths(controller.allItems);

//         return ListView.builder(
//           itemCount: uniqueLengths.length,
//           itemBuilder: (context, index) {
//             final length = uniqueLengths[index];
//             return ListTile(
//               title: Text('Alphabet Length: $length'),
//               onTap: () => _showMatchingBarcodesPage(length),
//             );
//           },
//         );
//       }),
//     );
//   }

//   List<int> _getUniqueAlphabetLengths(List<ItemModel> items) {
//     final Set<int> lengths = {};
//     for (var item in items) {
//       String barcode = item.barcode;
//       int alphabetLength = _getAlphabetLength(barcode);
//       if (alphabetLength > 0) {
//         lengths.add(alphabetLength);
//       }
//     }
//     return lengths.toList()..sort();
//   }

//   int _getAlphabetLength(String barcode) {
//     if (barcode.length >= 2 && _isAlphabetic(barcode.substring(0, 2))) {
//       return 2; // Both characters are alphabetic
//     } else if (barcode.length >= 1 && _isAlphabetic(barcode.substring(0, 1))) {
//       return 1; // Only the first character is alphabetic
//     }
//     return 0; // No alphabetic characters at the start
//   }

//   bool _isAlphabetic(String str) {
//     final RegExp alphabetic = RegExp(r'^[a-zA-Z]+$');
//     return alphabetic.hasMatch(str);
//   }

//   void _showMatchingBarcodesPage(int alphabetLength) {
//     List<ItemModel> matchingItems = controller.allItems
//         .where((item) => _getAlphabetLength(item.barcode) == alphabetLength)
//         .toList();

//     Get.to(() => MatchingBarcodesPage(matchingItems));
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(title: Text('SALE')),
      body: Obx(() {
        final uniqueAlphabets = _getUniqueAlphabets(controller.allItems);

        return ListView.builder(
          itemCount: uniqueAlphabets.length,
          itemBuilder: (context, index) {
            final alphabet = uniqueAlphabets[index];
            return ListTile(
              title: Text('$alphabet'),
              onTap: () => _showMatchingBarcodesPage(alphabet),
            );
          },
        );
      }),
    );
  }

  List<String> _getUniqueAlphabets(List<ItemModel> items) {
    final Set<String> alphabets = {};
    for (var item in items) {
      String barcode = item.barcode;
      String alphabet = _getAlphabet(barcode);
      if (alphabet.isNotEmpty) {
        alphabets.add(alphabet);
      }
    }
    return alphabets.toList()..sort();
  }

  String _getAlphabet(String barcode) {
    if (barcode.length >= 2 && _isAlphabetic(barcode.substring(0, 2))) {
      return barcode.substring(0, 2); // Both characters are alphabetic
    } else if (barcode.length >= 1 && _isAlphabetic(barcode.substring(0, 1))) {
      return barcode.substring(0, 1); // Only the first character is alphabetic
    }
    return ''; // No alphabetic characters at the start
  }

  bool _isAlphabetic(String str) {
    final RegExp alphabetic = RegExp(r'^[a-zA-Z]+$');
    return alphabetic.hasMatch(str);
  }

  void _showMatchingBarcodesPage(String alphabet) {
    List<ItemModel> matchingItems = controller.allItems
        .where((item) => _getAlphabet(item.barcode) == alphabet)
        .toList();

    Get.to(() => MatchingBarcodesPage(matchingItems));
  }
}

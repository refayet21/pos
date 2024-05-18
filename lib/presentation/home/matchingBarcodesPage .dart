import 'package:flutter/material.dart';
import 'package:loyverspos/model/item_model.dart';

class MatchingBarcodesPage extends StatelessWidget {
  final List<ItemModel> matchingItems;

  MatchingBarcodesPage(this.matchingItems);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Items'),
      ),
      body: ListView.builder(
        itemCount: matchingItems.length,
        itemBuilder: (context, index) {
          final item = matchingItems[index];
          return ListTile(
            title: Text(item.name),
            subtitle: Text(
                'Barcode: ${item.barcode}, Price: \$${item.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

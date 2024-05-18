import 'package:flutter/material.dart';

class MatchingBarcodesPage extends StatelessWidget {
  final List<String> matchingBarcodes;

  MatchingBarcodesPage(this.matchingBarcodes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Barcodes'),
      ),
      body: ListView.builder(
        itemCount: matchingBarcodes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(matchingBarcodes[index]),
          );
        },
      ),
    );
  }
}

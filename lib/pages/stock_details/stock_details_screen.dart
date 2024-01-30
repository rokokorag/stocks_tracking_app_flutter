import 'package:flutter/material.dart';

class StockDetailsScreen extends StatelessWidget {
  static const String name = 'stock_details_screen';
  static const String link = '/stockdetails';
  const StockDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Details'),
      ),
      body: const Center(
        child: Text('Stock Details Screen'),
      ),
    );
  }
}

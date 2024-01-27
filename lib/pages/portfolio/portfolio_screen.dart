import 'package:flutter/material.dart';

class PortfolioScreen extends StatelessWidget {
  static const String name = 'portfolio_screen';

  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks Tracking App'),
      ),
      body: const Center(
        child: Text('Portfolio Screen'),
      ),
    );
  }
}

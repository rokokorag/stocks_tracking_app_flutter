import 'package:flutter/material.dart';
import 'package:stocks_tracking_app/widgets/side_menu.dart';

class PortfolioScreen extends StatelessWidget {
  static const String name = 'portfolio_screen';
  static const String link = '/';

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
      drawer: const SideMenu(
        selectedMenu: 0,
      ),
    );
  }
}

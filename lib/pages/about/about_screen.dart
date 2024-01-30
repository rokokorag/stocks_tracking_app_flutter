import 'package:flutter/material.dart';
import 'package:stocks_tracking_app/widgets/side_menu.dart';

class AboutScreen extends StatelessWidget {
  static const String name = 'about_screen';
  static const String link = '/about';
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Center(
        child: Text('About Screen'),
      ),
      drawer: const SideMenu(selectedMenu: 1),
    );
  }
}

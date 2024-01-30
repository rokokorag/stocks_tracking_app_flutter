import 'package:flutter/material.dart';
import 'package:stocks_tracking_app/pages/screens.dart';

class MenuItem {
  final String title;

  final String link;
  final IconData icon;

  const MenuItem({
    required this.title,
    required this.link,
    required this.icon,
  });
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: "Portfolio", link: PortfolioScreen.link, icon: Icons.dashboard),
  MenuItem(title: "About", link: AboutScreen.link, icon: Icons.info_outline),
];

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stocks_tracking_app/config/menu.dart';
import 'package:stocks_tracking_app/providers/state_provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text(context.read<StateProvider>().userData.email),
        ),
        ...appMenuItems.map((menu) => NavigationDrawerDestination(
            icon: Icon(menu.icon), label: Text(menu.title))),
        const Divider(),
        TextButton.icon(
          onPressed: () {},
          label: const Text("Sign out"),
          icon: const Icon(Icons.logout),
        )
      ],
    );
  }
}

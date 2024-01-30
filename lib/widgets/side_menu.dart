import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stocks_tracking_app/config/menu.dart';
import 'package:stocks_tracking_app/providers/state_provider.dart';

class SideMenu extends StatefulWidget {
  final int selectedMenu;
  const SideMenu({super.key, required this.selectedMenu});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndexSelected = 0;

  @override
  void initState() {
    super.initState();
    navDrawerIndexSelected = widget.selectedMenu;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: navDrawerIndexSelected,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndexSelected = value;
        });
        final menuItem = appMenuItems[value];
        context.go(menuItem.link);
        //widget.scaffoldKey.currentState?.closeDrawer();
      },
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

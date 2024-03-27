import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stocks_tracking_app/config/menu.dart';
import 'package:stocks_tracking_app/presentation/blocs/user_data_bloc/user_data_bloc.dart';
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
      },
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: context.select((UserDataBloc userDataBloc) => Text(
                (userDataBloc.state as GetUserDataState).userData.email,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary),
              )),

          // Text(
          //   context.read<StateProvider>().userData.email,
          //   textAlign: TextAlign.left,
          //   style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 15,
          //       color: Theme.of(context).colorScheme.primary),
          // ),
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          height: 10,
        ),
        ...appMenuItems.map((menu) => NavigationDrawerDestination(
            icon: Icon(menu.icon), label: Text(menu.title))),
        const SizedBox(
          height: 10,
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: Theme.of(context).colorScheme.primary,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: TextButton.icon(
            onPressed: () {
              context.read<UserDataBloc>().logout();
              context.go('/login');
              // context.read<StateProvider>().logOut();
              // context.go('/login');
            },
            label: const Text("Sign out"),
            icon: const Icon(Icons.logout),
          ),
        )
      ],
    );
  }
}

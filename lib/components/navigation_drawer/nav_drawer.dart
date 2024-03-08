import 'package:flutter/material.dart';

import 'nav_drawer_header.dart';
import 'nav_drawer_items.dart';

class NavDrawer extends StatelessWidget {
  final BuildContext baseContext;

  const NavDrawer({super.key, required this.baseContext});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const NavDrawerHeader(),
            NavDrawerItemList(context: baseContext)
          ],
        ),
      ),
    ));
  }
}

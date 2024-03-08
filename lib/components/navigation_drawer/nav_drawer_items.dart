import 'package:eds_survey/ui/login/LoginScreen.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dialogs/logout_confirmation_dialog.dart';

class NavDrawerItemList extends StatefulWidget {
  final BuildContext context;

  const NavDrawerItemList({super.key, required this.context});

  @override
  State<NavDrawerItemList> createState() => _NavDrawerItemListState();
}

class _NavDrawerItemListState extends State<NavDrawerItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 15.0),
      // margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          menuItem(1, "My Account", FontAwesomeIcons.solidUserCircle),
          menuItem(2, "Check for Update", Icons.refresh),
          menuItem(3, "Version", Icons.abc),
          menuItem(4, "Logout", Icons.login_outlined),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon) {
    return Material(
      color: Colors.white,
      child: InkWell(
          onTap: () {
            navigate(id);
          },
          child: ListTile(
            leading: Icon(
              icon,
              size: 20,
              color: Colors.black,
            ),
            title: Text(
              title,
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
            ),
          )),
    );
  }

  void navigate(int id) {
    switch (id) {
      case 1:
        Fluttertoast.showToast(msg: "Account");
        break;
      case 2:
        Fluttertoast.showToast(msg: "Update");
        break;
      case 3:
        Fluttertoast.showToast(msg: "Version");
        break;
      case 4:
        showDialog(
          context: context,
          builder: (context) {
            return LogoutConfirmationDialog(
                onConfirm: () => logout(),
                onCancel: () => Navigator.of(context).pop());
          },
        );
        break;
      // //logout tab
      //   case 5:
      //     Navigator.of(widget.context).pop();
      //     showDialog(
      //       context: widget.context,
      //       builder: (context) {
      //         return LogoutConfirmationDialog(
      //           onConfirm: logout,
      //           onCancel: () => Navigator.of(context).pop(),
      //         );
      //       },
      //     );
      //     break;
    }
  }

  void logout() {
    PreferenceUtil.getInstance().then((preferenceUtil){
      preferenceUtil.clearAllPreferences();
    });
    Navigator.of(context).pop();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
    Fluttertoast.showToast(msg: "Logout Success");
    //clear local storage
    //   SecureStorage.getInstance().clearLocalData();
    //   Navigator.pushReplacement(
    //       widget.context,
    //       MaterialPageRoute(
    //         builder: (context) => const AuthScreen(),
    //       ));
    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Center(
    //         child: Text("Log out success"),
    //       )));
  }
}

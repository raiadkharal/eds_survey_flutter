import 'package:eds_survey/Route.dart';
import 'package:eds_survey/ui/home/HomeViewModel.dart';
import 'package:eds_survey/ui/login/LoginScreen.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../dialogs/LogoutConfirmationDialog.dart';

class NavDrawerItemList extends StatefulWidget {
  final BuildContext context;

  const NavDrawerItemList({super.key, required this.context});

  @override
  State<NavDrawerItemList> createState() => _NavDrawerItemListState();
}

class _NavDrawerItemListState extends State<NavDrawerItemList> {

  final PreferenceUtil _preferenceUtil = Get.find<PreferenceUtil>();


  bool isDayStarted() {
    return _preferenceUtil.getWorkSyncData().isDayStarted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15.0),
      // margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          menuItem(1, "My Account", FontAwesomeIcons.solidUserCircle),
          menuItem(2, "Outlet Request", FontAwesomeIcons.file),
          menuItem(3, "Check for Update", Icons.refresh),
          menuItem(4, "Version", Icons.abc),
          menuItem(5, "Logout", Icons.login_outlined),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon) {
    return InkWell(
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
        ));
  }

  void navigate(int id) {
    switch (id) {
      case 1:
        Fluttertoast.showToast(msg: "Account");
        break;
      case 2:
        if(isDayStarted()) {
          Navigator.of(context).pop();
          Get.toNamed(Routes.outletRequest);
        }else{
          showToastMessage(Constants.ERROR_DAY_NO_STARTED);
        }
        break;
      case 3:
        Fluttertoast.showToast(msg: "Update");
        break;
      case 4:
        Fluttertoast.showToast(msg: "Version");
        break;
      case 5:
        showDialog(
          context: context,
          builder: (context) {
            return LogoutConfirmationDialog(
                onConfirm: () => logout(),
                onCancel: () => Navigator.of(context).pop());
          },
        );
        break;
    }
  }

  void logout() {
    PreferenceUtil.getInstance().then((preferenceUtil) {
      preferenceUtil.clearAllPreferences();
    });
    Get.offAll(LoginScreen());
    Fluttertoast.showToast(msg: "Logout Success");
  }
}

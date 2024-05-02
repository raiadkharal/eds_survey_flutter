import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/Colors.dart';
import '../../utils/PreferenceUtil.dart';

class NavDrawerHeader extends StatelessWidget {
  NavDrawerHeader({super.key});

  final PreferenceUtil _preferenceUtil = Get.find<PreferenceUtil>();


  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.account_circle_rounded,
                  size: 72,
                  color: Colors.grey,
                ),
                Text(
                  _preferenceUtil.getUsername(),
                  style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:eds_survey/ui/home/HomeViewModel.dart';
import 'package:eds_survey/ui/market_visit/load_outlets/LoadOutletsScreen.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../components/buttons/home_button.dart';
import '../../components/navigation_drawer/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    homeViewModel.checkDayEnd();

    PreferenceUtil.getInstance().then((preferenceUtil) {
      Fluttertoast.showToast(
          msg:
              "Username: ${preferenceUtil.getUsername()} \n Token: ${preferenceUtil.getToken()}");
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, child) {
        return Scaffold(
          drawer: NavDrawer(
            baseContext: context,
          ),
          appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
              // leading: IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       Icons.menu,
              //       color: Colors.white,
              //     )),
              title: Expanded(
                  child: Text(
                "EDS Survey",
                style: GoogleFonts.roboto(color: Colors.white),
              ))),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Constants.homeButtonsPadding),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Start Day
                      HomeButton(
                        onTap: () {
                          if (homeViewModel.startDay) {
                            Fluttertoast.showToast(
                                msg: "Day Already has been started");
                          } else {
                            homeViewModel.start();
                          }
                        },
                        text: "Start Day",
                        iconData: Icons.alarm,
                        color:
                            homeViewModel.startDay ? Colors.grey : primaryColor,
                      ),
                      const SizedBox(
                        width: Constants.homeButtonsPadding,
                      ),

                      //Download data
                      HomeButton(
                        onTap: () {
                          Fluttertoast.showToast(msg: "Download");
                        },
                        text: "Download",
                        iconData: Icons.cloud_download_rounded,
                        color: Colors.blueAccent,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: Constants.homeButtonsPadding,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeButton(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Market Visit");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const LoadOutletsScreen(),
                                ));
                          },
                          text: "Market Visit",
                          iconData: Icons.file_open_sharp,
                          color: Colors.blueAccent),
                      const SizedBox(
                        width: Constants.homeButtonsPadding,
                      ),
                      HomeButton(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Work With");
                          },
                          text: "Work * With",
                          iconData: Icons.file_open_rounded,
                          color: primaryColor)
                    ],
                  ),
                ),
                const SizedBox(
                  height: Constants.homeButtonsPadding,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeButton(
                          onTap: () {
                            Fluttertoast.showToast(msg: "End Day");
                          },
                          text: "End Day",
                          iconData: Icons.alarm_off,
                          color: primaryColor),
                      const SizedBox(
                        width: Constants.homeButtonsPadding,
                      ),
                      HomeButton(
                          onTap: () {
                            Fluttertoast.showToast(msg: "Upload");
                          },
                          text: "Upload",
                          iconData: Icons.cloud_upload,
                          color: Colors.blueAccent)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

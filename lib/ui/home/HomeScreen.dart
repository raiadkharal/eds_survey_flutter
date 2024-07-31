import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/dialog/sku_avalability/sku_availability_dialog.dart';
import 'package:eds_survey/components/progress_dialog/PregressDialog.dart';
import 'package:eds_survey/data/models/WorkStatus.dart';
import 'package:eds_survey/di/bindings/Bindings.dart';
import 'package:eds_survey/ui/home/HomeViewModel.dart';
import 'package:eds_survey/ui/priorities/PrioritiesScreen.dart';
import 'package:eds_survey/ui/work_with/main/WorkWithMainScreen.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/button/HomeButton.dart';
import '../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../data/db/entities/outlet_request/RequestForm.dart';
import '../../utils/Util.dart';
import '../../utils/Utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel controller = Get.find<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    setObservers();
    controller.checkDayEnd();
  }

  int counterMultipleApi = 0;

  int clickCode = Constants.NEW_OUTLET_REQUEST;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(
          baseContext: context,
        ),
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            title: Text(
              "EDS Survey",
              style: GoogleFonts.roboto(color: Colors.white),
            )),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Start Day
                        Expanded(
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Obx(
                                () => HomeButton(
                                  onTap: () {
                                    if (controller.startDay().value) {
                                      return null;
                                    } else {
                                      controller.start();
                                    }
                                  },
                                  text: "Start Day",
                                  iconData: Icons.alarm,
                                  color: controller.startDay().value
                                      ? Colors.grey.shade500
                                      : primaryColor,
                                ),
                              ),
                              Obx(() => controller.startDay().value
                                  ? Positioned(
                                      bottom: 20,
                                      child: Text(
                                        "( ${controller.lastSyncDate.value} )",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white),
                                      ))
                                  : const SizedBox())
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: Constants.homeButtonsPadding,
                        ),

                        //Download data
                        Expanded(
                          child: HomeButton(
                            onTap: () {
                              if (controller.isDayStarted()) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(5))),
                                    insetPadding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Update Routes and Outlets!",
                                            style: GoogleFonts.roboto(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                              "Are you sure you want to fetch updated routes and outlets?",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "NO",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    controller.download();
                                                  },
                                                  child: Text("YES",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400)))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                showToastMessage(Constants.ERROR_DAY_NO_STARTED);
                              }
                            },
                            text: "Download",
                            iconData: Icons.cloud_download_rounded,
                            color: Colors.blueAccent,
                          ),
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
                        Expanded(
                          child: HomeButton(
                              onTap: () {
                                if (controller.isDayStarted()) {
                                  Get.toNamed(Routes.loadOutlets);
                                } else {
                                  showToastMessage(
                                      Constants.ERROR_DAY_NO_STARTED);
                                }
                              },
                              text: "Market Visit",
                              iconData: Icons.file_open_sharp,
                              color: Colors.blueAccent),
                        ),
                        const SizedBox(
                          width: Constants.homeButtonsPadding,
                        ),
                        Expanded(
                          child: HomeButton(
                              onTap: () {
                                if (controller.isDayStarted()) {
                                  Get.toNamed(Routes.workWithMain);
                                } else {
                                  showToastMessage(
                                      Constants.ERROR_DAY_NO_STARTED);
                                }
                              },
                              text: "Work * With",
                              iconData: Icons.file_open_rounded,
                              color: primaryColor),
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
                        Expanded(
                          child: HomeButton(
                              onTap: () {
                                if (controller.isDayStarted()) {
                                  controller.dayEnd();
                                } else {
                                  showToastMessage(
                                      Constants.ERROR_DAY_NO_STARTED);
                                }
                              },
                              text: "End Day",
                              iconData: Icons.alarm_off,
                              color: primaryColor),
                        ),
                        const SizedBox(
                          width: Constants.homeButtonsPadding,
                        ),
                        Expanded(
                          child: HomeButton(
                              onTap: () {
                                if (controller.isDayStarted()) {
                                  Get.toNamed(Routes.upload);
                                } else {
                                  showToastMessage(
                                      Constants.ERROR_DAY_NO_STARTED);
                                }
                              },
                              text: "Upload",
                              iconData: Icons.cloud_upload,
                              color: Colors.blueAccent),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => controller.isLoading().value
                  ? const SimpleProgressDialog()
                  : const SizedBox(),
            ),
          ],
        ));
  }

  void setObservers() {
    debounce(controller.getRoutesLiveData(), (routesModel) {
      if (bool.parse(routesModel.success ?? "true")) {
        controller.deleteTables(true);
        controller.addDocuments(routesModel.documents);
        controller.addOutlets(routesModel.outlets);

//                if (syncCallback != null) {
//                    if (progressDialog != null)
//                        progressDialog.dismiss();
//                    syncCallback.onSync();
//                }

//                if (progressDialog != null)
//                    progressDialog.dismiss();
      } else {
        showToastMessage(routesModel.errorMessage.toString());
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getMessage(), (value) {
      showToastMessage(value.peekContent());
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getProgressMsg(), (value) {
      showToastMessage(value.peekContent());
    }, time: const Duration(milliseconds: 200));

    debounce(controller.startDay(), (aBoolean) {
      if (aBoolean) {
        String startDate = Util.formatDate(
            Util.DATE_FORMAT_3, controller.getWorkSyncData().syncDate);

        controller.setSyncDate(startDate);

        //Day started message dialog
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    "Day Started! ( $startDate )",
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your day has been started",
                          style: GoogleFonts.roboto(fontSize: 16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Ok",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 16),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ));
      } else {
        WorkStatus status = WorkStatus(0);
        controller.saveWorkSyncData(status);
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.endDay, (aBoolean) {
      if (aBoolean) {
        String endDate = Util.formatDate(
            Util.DATE_FORMAT_3, controller.getWorkSyncData().syncDate);

        //Day End Confirmation dialog
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Day Closing! ( $endDate )",
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Are you sure you want to end your day? After ending your day you will not be able to take any Survey",
                        style: GoogleFonts.roboto(fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: Navigator.of(context).pop,
                              child: Text(
                                "No",
                                style: GoogleFonts.roboto(color: Colors.black),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                controller.updateDayEndStatus();
                              },
                              child: Text(
                                "Yes",
                                style: GoogleFonts.roboto(color: Colors.black),
                              )),
                        ],
                      )
                    ],
                  ),
                ));
      }
    }, time: const Duration(milliseconds: 200));
  }

  void multipleSyncWithCallBack(int counterMultipleApi, int clickCode) {}
}

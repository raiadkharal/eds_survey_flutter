import 'package:eds_survey/components/CustomDropdownButton.dart';
import 'package:eds_survey/components/button/CustomButton.dart';
import 'package:eds_survey/data/WorkWithSingletonModel.dart';
import 'package:eds_survey/data/db/entities/distribution.dart';
import 'package:eds_survey/ui/market_visit/SurveyViewModel.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletsScreen.dart';
import 'package:eds_survey/ui/work_with/main/WorkWithMainViewModel.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Route.dart';
import '../../../components/progress_dialog/PregressDialog.dart';
import '../../../data/db/entities/route.dart';
import '../../../data/db/entities/workwith/WDistribution.dart';
import '../../../data/db/entities/workwith/WRoute.dart';
import '../../../utils/Utils.dart';

class WorkWithMainScreen extends StatefulWidget {
  const WorkWithMainScreen({super.key});

  @override
  State<WorkWithMainScreen> createState() => _WorkWithMainScreenState();
}

class _WorkWithMainScreenState extends State<WorkWithMainScreen> {
  final WorkWithMainViewModel controller = Get.find<WorkWithMainViewModel>();

  @override
  void initState() {
    setObservers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "LOAD OUTLETS",
          style: GoogleFonts.roboto(color: Colors.black),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Distribution",
                  style: GoogleFonts.roboto(),
                ),
                FutureBuilder(
                  future: controller.distributions,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      controller
                          .setSelectedDistribution(snapshot.requireData[0]);
                      return CustomDropdownButton<WDistribution>(
                        items: snapshot.requireData,
                        value: snapshot.requireData[0],
                        displayValue: (item) =>
                            item.distributionName ?? "No Distributions",
                        onChanged: (distribution) {
                          if(distribution!=null) {
                            controller.setSelectedDistribution(distribution);
                          }
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Routes",
                  style: GoogleFonts.roboto(),
                ),
                FutureBuilder<List<WRoute>>(
                  future: controller.routes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if(snapshot.requireData.isNotEmpty) {
                        controller.setSelectedRouteId(snapshot.requireData[0]);
                      }
                      return CustomDropdownButton<WRoute>(
                        items: snapshot.requireData,
                        value: snapshot.requireData[0],
                        displayValue: (item) => item.mRouteName ?? "No Routes",
                        onChanged: (route) {
                          if(route!=null) {
                            controller.setSelectedRouteId(route);
                          }
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomButton(
                    onTap: () {
                      controller
                          .workWithOutletCount(controller.getSelectedRouteId())
                          .then((outletCount) {
                        if (outletCount == 0) {
                          controller.getWorkWithOutlets(
                              controller.getSelectedRouteId());
                        } else {
                          if (controller.getSelectedDistributionId() != 0 &&
                              controller.getSelectedRouteId() != 0) {
                            controller.validate();
                          }
                        }
                      }).onError((error, stackTrace) {
                        showToastMessage(error.toString());
                      });
                    },
                    text: "Load Outlets")
              ],
            ),
          ),
          Obx(
            () => controller.isLoading().value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void setObservers() {
    debounce(controller.isWorkWithOutletsLoaded(), (isLoaded) {
      if (isLoaded) {
        controller.validate();
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getMessage(), (value) {
      showToastMessage(value.peekContent());
    }, time: const Duration(milliseconds: 200));

    debounce(controller.msg, (msg) => showToastMessage(msg),
        time: const Duration(milliseconds: 200));

    debounce(controller.navigate, (aBoolean) {
      if (aBoolean) {
        //navigate to Outlet list screen
        Get.toNamed(Routes.outletList, arguments: [
          controller.getSelectedRouteId(),
          controller.getSelectedDistributionId(),
          SurveyType.SURVEY_WITH
        ]);
      }
    }, time: const Duration(milliseconds: 200));
    debounce(controller.psrLiveData, (psrs) {
      if (psrs.isNotEmpty) {
        WorkWithSingletonModel.getInstance().setPsrCode(psrs[0].psrCode ?? "");
        WorkWithSingletonModel.getInstance().setPsrId(psrs[0].psrId);
      }
    }, time: const Duration(milliseconds: 200));
  }
}

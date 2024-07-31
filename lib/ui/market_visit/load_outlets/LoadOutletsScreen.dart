import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/CustomDropdownButton.dart';
import 'package:eds_survey/components/button/CustomButton.dart';
import 'package:eds_survey/data/db/entities/distribution.dart';
import 'package:eds_survey/ui/market_visit/SurveyViewModel.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletsScreen.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/progress_dialog/PregressDialog.dart';
import '../../../data/db/entities/route.dart';
import '../../../utils/Utils.dart';

class LoadOutletsScreen extends StatefulWidget {
  const LoadOutletsScreen({super.key});

  @override
  State<LoadOutletsScreen> createState() => _LoadOutletsScreenState();
}

class _LoadOutletsScreenState extends State<LoadOutletsScreen> {
  final SurveyViewModel controller = Get.find<SurveyViewModel>();

  @override
  void initState() {
    super.initState();

    controller.loadData();
    setObservers();
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
                      if (snapshot.hasData&&snapshot.requireData.isNotEmpty) {
                        controller
                            .setSelectedDistribution(snapshot.requireData[0]);
                        return CustomDropdownButton<Distribution>(
                          items: snapshot.requireData,
                          value: snapshot.requireData[0],
                          displayValue: (item) =>
                              item.distributionName ?? "No Distribution Name",
                          onChanged: (distribution) {
                            if (distribution != null) {
                              controller.setSelectedDistribution(distribution);
                            }
                          },
                        );
                      } else {
                        return Expanded(
                            child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                                "Distributions not found. Please download data again!"),
                          ),
                        ));
                      }
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
                FutureBuilder<List<MRoute>>(
                  future: controller.routes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData&&snapshot.requireData.isNotEmpty) {
                        controller.setSelectedRouteId(snapshot.requireData[0]);
                        return CustomDropdownButton<MRoute>(
                          items: snapshot.requireData,
                          value: snapshot.requireData[0],
                          displayValue: (item) => item.routeName ?? "No Route name",
                          onChanged: (route) {
                            if (route != null) {
                              controller.setSelectedRouteId(route);
                            }
                          },
                        );
                      } else {
                        return Expanded(
                            child:  Container(
                              color: Colors.white,
                              child: const Center(
                                child: Text(
                                    "Routes not found. Please download data again!"),
                              ),
                            ));
                      }
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
                          .marketVisitCount(controller.getSelectedRouteId())
                          .then((outletCount) {
                        if (outletCount == 0) {
                          controller.getMarketVisitOutlets(
                              controller.getSelectedRouteId());
                        } else {
                          if (controller.getSelectedDistributionId() != 0 &&
                              controller.getSelectedRouteId() != 0) {
                            //navigate to Outlet list screen
                            Get.toNamed(Routes.outletList, arguments: [
                              controller.getSelectedRouteId(),
                              controller.getSelectedDistributionId(),
                              SurveyType.MARKET_VISIT
                            ]);
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
          ),
        ],
      ),
    );
  }

  void setObservers() {
    debounce(controller.isMarketVisitOutletsLoaded(), (isLoaded) {
      if (isLoaded) {
        if (controller.getSelectedDistributionId() != 0 &&
            controller.getSelectedRouteId() != 0) {
          //navigate to Outlet list screen with arguments
          Get.toNamed(Routes.outletList, arguments: [
            controller.getSelectedRouteId(),
            controller.getSelectedDistributionId(),
            SurveyType.MARKET_VISIT
          ]);
        }
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getMessage(), (value) {
      showToastMessage(value.peekContent());
    }, time: const Duration(milliseconds: 200));
  }
}

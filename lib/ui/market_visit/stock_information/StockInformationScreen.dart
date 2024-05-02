import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/progress_dialogs/PregressDialog.dart';
import 'package:eds_survey/ui/market_visit/coolers_verification/CoolerVerificationScreen.dart';
import 'package:eds_survey/ui/market_visit/expired_stock/ExpiredStockScreen.dart';
import 'package:eds_survey/ui/market_visit/stock_information/StockInformationViewModel.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/CustomButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Enums.dart';

class StockInformationScreen extends StatefulWidget {
  const StockInformationScreen({super.key});

  @override
  State<StockInformationScreen> createState() => _StockInformationScreenState();
}

class _StockInformationScreenState extends State<StockInformationScreen> {
  final StockInformationViewModel controller =
      Get.put(StockInformationViewModel(Get.find()));

  late final int outletId;
  late final SurveyType surveyType;

  // final List<String> checkList1 = ["250ml RB1", "250ml CAN1", "300ml Can1"];
  // final List<String> checkList2 = ["250ml RB", "250ml CAN", "300ml Can"];
  // final List<String> checkList3 = ["250ml RB3", "250ml CAN3", "300ml Can3"];

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          //     icon: const Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //     )),
          title: Text(
            "EDS Survey",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "STOCK INFORMATION",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            color: Colors.grey.shade200,
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "SKUS-Availability CheckList",
              style: GoogleFonts.roboto(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: controller.loadSkus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<String> checkList1 = snapshot.requireData ?? [];
                return Container(
                  color: Colors.grey.shade200,
                  child: ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "${index + 1}.SKUS-Availability CheckList-${index + 1}",
                                style: GoogleFonts.roboto(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: checkList1.length,
                              itemBuilder:
                                  (BuildContext context, int sectionIndex) {
                                String item = checkList1[sectionIndex];
                                return Row(
                                  children: [
                                    Obx(
                                      () => Checkbox(
                                          value: controller.selectedItems.value
                                              .contains(item),
                                          onChanged: (value) {
                                            controller.toggleItem(item);
                                            controller.addMarketVisitResponse(
                                                item, index);
                                          }),
                                    ),
                                    Text(
                                      item,
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const SimpleProgressDialog();
              }
            },
          )),
          CustomButton(
            onTap: () {
              if (controller.validate()) {
                controller.setData();

                Get.toNamed(Routes.coolerVerification,
                    arguments: [outletId, surveyType])?.then((value) {
                  controller.onResumed();
                });
              } else {
                showToastMessage("Please select option");
              }
            },
            text: "Next",
            enabled: true,
            fontSize: 22,
            horizontalPadding: 10,
          ),
        ],
      ),
    );
  }
}

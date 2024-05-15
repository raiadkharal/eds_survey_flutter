import 'dart:io';

import 'package:eds_survey/Route.dart';
import 'package:eds_survey/data/models/Configuration.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/market_visit/coolers_verification/CoolerVerificationViewModel.dart';
import 'package:eds_survey/ui/market_visit/coolers_verification/QuestionListItem.dart';
import 'package:eds_survey/ui/market_visit/expired_stock/ExpiredStockScreen.dart';
import 'package:eds_survey/ui/market_visit/stock_information/StockInformationScreen.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/buttons/CustomButton.dart';
import '../../../components/dropdowns/SimpleDropdownButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../data/MarketVisitResponse.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Enums.dart';

class CoolerVerificationScreen extends StatefulWidget {
  const CoolerVerificationScreen({
    super.key,
  });

  @override
  State<CoolerVerificationScreen> createState() =>
      _CoolerVerificationScreenState();
}

class _CoolerVerificationScreenState extends State<CoolerVerificationScreen> {
  final List<String> questions = [
    "Cooler Working",
    "Cooler at First/Prime Position",
    "Cooler Fullness",
    "Cooler Purity"
  ];

  late final int outletId;
  late final SurveyType surveyType;

  bool isEngroUser = false;

  final List<String> verify = ["", "Yes", "No"];

  final List<String> percentage = [
    "",
    "0-20%",
    "21-40%",
    "41-60%",
    "61-80%",
    "81-100%"
  ];

  String cVcCiPepsi = "";

  String cVcClPepsi = "";

  String cVcwPepsi = "";

  String cVccPepsiString = "";

  final CoolerVerificationViewModel controller =
      Get.put(CoolerVerificationViewModel(Get.find<Repository>()));

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];

    init();

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
              "COOLER VERIFICATION",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.grey.shade200,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text(
                            "Cooler info",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            isEngroUser ? "Engro" : "PEPSI",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        return CoolerQuestionListItem(
                          text: questions[index],
                          options: index <= 1 ? verify : percentage,
                          onChanged: (value) {
                            String parsedValue =value as String;
                            switch (index) {
                              case 0:
                                cVcwPepsi =parsedValue;
                                break;
                              case 1:
                                cVccPepsiString = parsedValue;
                                break;
                              case 2:
                                cVcClPepsi = parsedValue;
                                break;
                              case 3:
                                cVcCiPepsi = parsedValue;
                                break;
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            onTap: () => onNextClick(context),
            text: "Next",
            enabled: true,
            fontSize: 22,
            horizontalPadding: 10,
          ),
        ],
      ),
    );
  }

  void onNextClick(BuildContext context) {
    Get.toNamed(Routes.expiredStock, arguments: [outletId, surveyType]);

    List<MarketVisitResponse> marketVisitResponseList = [];

    if (cVcwPepsi.isNotEmpty &&
        cVccPepsiString.isNotEmpty &&
        cVcClPepsi.isNotEmpty &&
        cVcCiPepsi.isNotEmpty) {
      marketVisitResponseList
          .add(MarketVisitResponse("CV", "CV_CW", cVcwPepsi));
      marketVisitResponseList
          .add(MarketVisitResponse("CV", "CV_FP", cVccPepsiString));
      marketVisitResponseList
          .add(MarketVisitResponse("CV", "CV_CF", cVcClPepsi));
      marketVisitResponseList
          .add(MarketVisitResponse("CV", "CV_CP", cVcCiPepsi));

      controller.setData(marketVisitResponseList);
    } else {
      showToastMessage("Please Select Option");
    }
  }

  void init() {
    Configuration configuration = controller.getConfiguration();

    if (configuration.tenantId == 2) {
      isEngroUser = true;
    } else {
      isEngroUser = false;
    }
  }
}

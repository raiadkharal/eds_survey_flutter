import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/dropdown/SimpleDropdownExpiredStock.dart';
import 'package:eds_survey/components/progress_dialog/PregressDialog.dart';
import 'package:eds_survey/ui/market_visit/expired_stock/ExpiredStockViewModel.dart';
import 'package:eds_survey/ui/market_visit/feedback/SurveyFeedbackScreen.dart';
import 'package:eds_survey/ui/priorities/PrioritiesScreen.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/button/CustomButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../data/MarketVisitResponse.dart';
import '../../../data/SurveySingletonModel.dart';
import '../../../data/models/LookUpObject.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Enums.dart';

class ExpiredStockScreen extends StatefulWidget {
  const ExpiredStockScreen({super.key});

  @override
  State<ExpiredStockScreen> createState() => _ExpiredStockScreenState();
}

class _ExpiredStockScreenState extends State<ExpiredStockScreen> {
  final ExpiredStockViewModel controller = Get.put(ExpiredStockViewModel(Get.find()));

  late final int outletId;
  late final SurveyType surveyType;

  final questionOneController = TextEditingController();

  final questionTwoController = TextEditingController();

  final questionThreeController = TextEditingController();

  List<MarketVisitResponse> marketVisitResponses = [];

  MarketVisitResponse? expiredStockResponse,
      pack1,
      pack2,
      pack3,
      brand1,
      brand2,
      brand3;

  int? packId1, packId2, packId3;

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];

    controller.getBrandsAndPackages();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top +
                  AppBar().preferredSize.height),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Screen label
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Expired STOCK INFORMATION",
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              //expired stock question
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1. Expired Stock",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        ListTile(
                          title: Text(
                            "Yes",
                            style: GoogleFonts.roboto(color: Colors.black87),
                          ),
                          leading: Obx(
                                () => Radio<ExpiredStock>(
                              value: ExpiredStock.yes,
                              activeColor: Colors.blueAccent,
                              groupValue: controller.expiredStock.value,
                              onChanged: (value) {
                                expiredStockResponse =
                                    MarketVisitResponse("ES", "ES_ES", "Yes");
                                controller.setExpiredStock(value!);
                              },
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "No",
                            style: GoogleFonts.roboto(color: Colors.black87),
                          ),
                          leading: Obx(
                                () => Radio<ExpiredStock>(
                              value: ExpiredStock.no,
                              groupValue: controller.expiredStock.value,
                              onChanged: (value) {
                                expiredStockResponse =
                                    MarketVisitResponse("ES", "ES_ES", "No");
                                controller.setExpiredStock(value!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //section view
              Obx(() {
                return controller.expiredStock.value == ExpiredStock.yes
                    ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Section",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          Text(
                            "Sub Section",
                            style: GoogleFonts.roboto(
                                fontSize: 14, color: Colors.black54),
                          ),

                          // Question 1
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "1",
                                style: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SimpleDropdownExpiredStock(
                                    options: controller.packages,
                                    hint: "Packs",
                                    onChanged: (selectedPack) {
                                      packId1 = selectedPack.key;
                                      controller.filterBrandsByPackage1(packId1);
                                      pack1 = MarketVisitResponse("ES",
                                          "ES_P1", selectedPack.value ?? "");
                                    },
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child:
                                Obx(() => SimpleDropdownExpiredStock(
                                  options: controller.brands,
                                  enabled: controller
                                      .brandsByPackage1
                                      .isNotEmpty,
                                  hint: "Brands",
                                  onChanged: (selectedBrand) {
                                    brand1 = MarketVisitResponse(
                                        "ES",
                                        "ES_B1",
                                        selectedBrand.value ??
                                            "");
                                  },
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 17.0),
                                    child: TextField(
                                      controller: questionOneController,
                                      decoration: InputDecoration(
                                          hintText: "Quantity",
                                          contentPadding:
                                          const EdgeInsets.only(
                                              top: 16, left: 10),
                                          hintStyle: GoogleFonts.roboto(
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                  ))
                            ],
                          ),
                          // section row widget 2
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "2",
                                style: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SimpleDropdownExpiredStock(
                                    options: controller.packages,
                                    onChanged: (selectedPack) {
                                      packId2 = selectedPack.key;
                                      controller.filterBrandsByPackage2(packId2);
                                      pack2 = MarketVisitResponse("ES",
                                          "ES_P2", selectedPack.value ?? "");
                                    },
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child:
                                Obx(() => SimpleDropdownExpiredStock(
                                  options: controller.brands,
                                  enabled: controller
                                      .brandsByPackage2
                                      .isNotEmpty,
                                  onChanged: (selectedBrand) {
                                    brand2 = MarketVisitResponse(
                                        "ES",
                                        "ES_B2",
                                        selectedBrand.value ??
                                            "");
                                  },
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 17.0),
                                    child: TextField(
                                      controller: questionTwoController,
                                      decoration: InputDecoration(
                                          hintText: "Quantity",
                                          contentPadding:
                                          const EdgeInsets.only(
                                              top: 16, left: 10),
                                          hintStyle: GoogleFonts.roboto(
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                  ))
                            ],
                          ),
                          // section row widget 3
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "3",
                                style: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SimpleDropdownExpiredStock(
                                    options: controller.packages,
                                    onChanged: (selectedPack) {
                                      packId3 = selectedPack.key;
                                      controller.filterBrandsByPackage3(packId3);
                                      pack3 = MarketVisitResponse("ES",
                                          "ES_P3", selectedPack.value ?? "");
                                    },
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child:
                                Obx(() => SimpleDropdownExpiredStock(
                                  options: controller.brands,
                                  enabled: controller
                                      .brandsByPackage3
                                      .isNotEmpty,
                                  onChanged: (selectedBrand) {
                                    brand3 = MarketVisitResponse(
                                        "ES",
                                        "ES_B3",
                                        selectedBrand.value ??
                                            "");
                                  },
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(bottom: 17.0),
                                    child: TextField(
                                      controller: questionThreeController,
                                      decoration: InputDecoration(
                                          hintText: "Quantity",
                                          contentPadding:
                                          const EdgeInsets.only(
                                              top: 16, left: 10),
                                          hintStyle: GoogleFonts.roboto(
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    : const SizedBox();
              }),
              const Expanded(child: SizedBox()),
              CustomButton(
                onTap: () {
                  onNextClick(context);
                },
                text: "Next",
                enabled: true,
                fontSize: 22,
                horizontalPadding: 10,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),

        ),
      ),
    );
  }

  void onNextClick(BuildContext context) {
    marketVisitResponses.clear();

    String quantityText = questionOneController.text;
    String quantityText2 = questionTwoController.text;
    String quantityText3 = questionThreeController.text;

    if (controller.expiredStock.value == ExpiredStock.yes) {

      if (quantityText2.isNotEmpty && pack2 != null && brand2 != null) {
        marketVisitResponses.add(pack2!);
        marketVisitResponses.add(brand2!);
        marketVisitResponses
            .add(MarketVisitResponse("ES", "ES_Q2", quantityText2));
      }

      if (quantityText3.isNotEmpty && pack3 != null && brand3 != null) {
        marketVisitResponses.add(pack3!);
        marketVisitResponses.add(brand3!);
        marketVisitResponses
            .add(MarketVisitResponse("ES", "ES_Q3", quantityText3));
      }

      if (quantityText.isNotEmpty && pack1 != null && brand1 != null) {
        marketVisitResponses.add(pack1!);
        marketVisitResponses.add(brand1!);
        marketVisitResponses
            .add(MarketVisitResponse("ES", "ES_Q1", quantityText));

        expiredMethod(context);
      } else {
        showToastMessage("Please select option");
      }

    } else {
      if (expiredStockResponse != null) {
        marketVisitResponses.add(expiredStockResponse!);
        expiredMethod(context);
      } else {
        showToastMessage("Please select option");
      }
    }
  }

  void expiredMethod(BuildContext context) {
    SurveySingletonModel.getInstance().addResponses(marketVisitResponses);
    if (surveyType == SurveyType.MARKET_VISIT) {
      Get.toNamed(Routes.priorities, arguments: [
        SurveySingletonModel.getInstance().getOutletId() ?? 0,
        surveyType
      ]);
    } else {
      Get.toNamed(Routes.surveyFeedback, arguments: [
        SurveySingletonModel.getInstance().getOutletId() ?? 0,
        surveyType
      ]);
    }
  }
}

enum ExpiredStock { defaultValue, yes, no }

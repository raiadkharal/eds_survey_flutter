import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/progress_dialog/PregressDialog.dart';
import 'package:eds_survey/ui/market_visit/competitor_stock_info/CometitorStockInformationViewModel.dart';
import 'package:eds_survey/ui/market_visit/stock_information/StockInformationViewModel.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/button/CustomButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../data/MarketVisitResponse.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Enums.dart';

class CompetitorStockInformationScreen extends StatefulWidget {
  const CompetitorStockInformationScreen({super.key});

  @override
  State<CompetitorStockInformationScreen> createState() =>
      _CompetitorStockInformationScreenState();
}

class _CompetitorStockInformationScreenState
    extends State<CompetitorStockInformationScreen> {
  final CompetitorStockInformationViewModel controller =
      Get.put(CompetitorStockInformationViewModel(Get.find()));

  final othersTextController = TextEditingController();

  late final int outletId;
  late final SurveyType surveyType;

  RxBool othersCheckBox = false.obs;

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
              "COMPETITOR STOCK INFORMATION",
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
                                            if (value ?? false) {
                                              controller.addMarketVisitResponse(
                                                  item, index);
                                            } else {
                                              controller.removeResponse(
                                                  MarketVisitResponse(
                                                      "CSI",
                                                      "CSI_C${index + 1}",
                                                      item));
                                            }
                                          }),
                                    ),
                                    Flexible(
                                      child: Text(
                                        item,
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => Checkbox(
                                    value: othersCheckBox.value,
                                    onChanged: (value) => othersCheckBox(value),
                                  ),
                                ),
                                Text(
                                  "Others",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                            Obx(
                              () => othersCheckBox.value
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 16),
                                      child: TextField(
                                        controller: othersTextController,
                                        maxLines: 2,
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.zero),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.zero),
                                            hintText:
                                                "Enter SKUs Name (comma separated)"),
                                      ),
                                    )
                                  : const SizedBox(),
                            )
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
            onTap: () => onNextClick(),
            text: "Next",
            enabled: true,
            fontSize: 22,
            horizontalPadding: 10,
          ),
        ],
      ),
    );
  }

  Future<void> onNextClick() async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (othersCheckBox.value) {
      if (othersTextController.text.toString().isEmpty) {
        showToastMessage("Please enter Sku name");
        return;
      }else{
        controller.addMarketVisitResponse(othersTextController.text.toString(), 1);
      }
    }

    if (controller.validate()) {
      controller.setData();

      Get.toNamed(Routes.coolerVerification, arguments: [outletId, surveyType])
          ?.then((result) {
        controller.onResumed();
        if(result=="ok"){
          Get.back(result: result);
        }
      });

    } else {
      showToastMessage("Please select option");
    }
  }
}

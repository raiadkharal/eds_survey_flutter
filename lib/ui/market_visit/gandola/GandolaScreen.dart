import 'package:eds_survey/data/MarketVisitResponse.dart';
import 'package:eds_survey/ui/market_visit/customer_service/CustomerServiceScreen.dart';
import 'package:eds_survey/ui/market_visit/gandola/GandolaViewModel.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Route.dart';
import '../../../components/button/CustomButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../data/SurveySingletonModel.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Enums.dart';

class GandolaScreen extends StatefulWidget {
  const GandolaScreen({super.key});

  @override
  State<GandolaScreen> createState() => _GandolaScreenState();
}

class _GandolaScreenState extends State<GandolaScreen> {
  final GandolaViewModel controller = Get.put(GandolaViewModel());

  late final int outletId;
  late final SurveyType surveyType;

  final List<String> _integrityList = [
    "0-20%",
    "21-40%",
    "41-60%",
    "61-80%",
    "81-100%"
  ];

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
      backgroundColor: Colors.grey.shade200,
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
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "G A N D O L A",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //Gandola options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. Gandola",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54),
                    ),
                    Obx(
                      () => ListTile(
                        title: Text(
                          "Yes",
                          style: GoogleFonts.roboto(color: Colors.black87),
                        ),
                        leading: Radio(
                          value: "Yes",
                          activeColor: Colors.blueAccent,
                          groupValue: controller.selectedValue.value,
                          onChanged: (value) {
                            controller.setGandolaSelectedValue(value!);
                            controller.isGandola.value = true;
                            controller.setQuestionOneResponse(value);
                          },
                        ),
                      ),
                    ),
                    Obx(() => ListTile(
                          title: Text(
                            "No",
                            style: GoogleFonts.roboto(color: Colors.black87),
                          ),
                          leading: Radio(
                            value: "No",
                            groupValue: controller.selectedValue.value,
                            onChanged: (value) {
                              controller.setGandolaSelectedValue(value!);
                              controller.isGandola.value = false;
                              controller.setQuestionOneResponse(value);
                            },
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Gandola Integrity
          Expanded(
            flex: 3,
            child: Obx(() => controller.isGandola.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "2. Gandola Integrity",
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _integrityList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      _integrityList[index],
                                      style: GoogleFonts.roboto(
                                          color: Colors.black87),
                                    ),
                                    leading: Obx(() =>  Radio(
                                      value: _integrityList[index],
                                      activeColor: Colors.blueAccent,
                                      groupValue:
                                      controller.selectedIntegrity.value,
                                      onChanged: (value) {
                                        controller.setSelectedIntegrity(value!);
                                        controller.setQuestionTwoResponse(value);
                                      },
                                    )),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox()),
          ),

          const Expanded(child: SizedBox()),
          CustomButton(
            onTap: ()=>onNextClick(),
            text: "Next",
            enabled: true,
            fontSize: 22,
            horizontalPadding: 10,
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Future<void> onNextClick() async {
    List<MarketVisitResponse> marketVisitResponseList = [];

    if (controller.questionOneResponse != null) {
      marketVisitResponseList.add(controller.questionOneResponse!);

      if (controller.isGandola.value) {
        if (controller.questionTwoResponse == null) {
          showToastMessage("Please select option");
          return;
        } else {
          marketVisitResponseList.add(controller.questionTwoResponse!);
        }
      } else {
        if (controller.questionTwoResponse != null) {
          int index = SurveySingletonModel.getInstance()
              .getQuestionsCode()
              .indexOf("G_GI");
          if (index != -1) {
            SurveySingletonModel.getInstance()
                .getMarketVisitResponses()
                .removeAt(index);
            SurveySingletonModel.getInstance().getQuestionsCode().removeAt(index);
          }
        }
      }

      SurveySingletonModel.getInstance().addResponses(marketVisitResponseList);

      //navigate to next screen
      final result = await Get.toNamed(Routes.customerService,
          arguments: [outletId, surveyType]);

      if(result=="ok"){
        Get.back(result: result);
      }

    } else {
      showToastMessage("Please select option");
    }
  }
}

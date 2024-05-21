import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/dropdown/SimpleDropdownExpiredStock.dart';
import 'package:eds_survey/components/dropdown/customer_service_dropdown.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/market_visit/coolers_verification/CoolerVerificationScreen.dart';
import 'package:eds_survey/ui/market_visit/customer_service/CustomerServiceViewModel.dart';
import 'package:eds_survey/ui/market_visit/stock_information/StockInformationScreen.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/button/CustomButton.dart';
import '../../../components/dropdown/SimpleDropdownButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../data/MarketVisitResponse.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Enums.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({
    super.key,
  });

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final CustomerServiceViewModel controller =
      Get.put(CustomerServiceViewModel(Get.find<Repository>()));

  late final int outletId;
  late final SurveyType surveyType;

  final List<String> questions = [
    "Is delivery made on time",
    "Is Invoice given by DM ?",
    "Are coolers and other complaints handled in time?",
    "Shopkeeper receiving Order SMS Alert"
  ];

  String cs1DmotPepsi = "";

  String cS1ItdaPepsi = "";

  String cS1ChitPepsi = "";

  String cS1SaopPepsi = "";

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];

    setObservers();
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
              "CUSTOMER SERVICE",
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
                          width: 200,
                          child: Text(
                            "Information from the shopkeeper",
                            style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            controller.getConfiguration().tenantId == 2
                                ? "ENGRO"
                                : "PEPSI",
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
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  questions[index],
                                  style: GoogleFonts.roboto(
                                      color: primaryColor,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: CustomerServiceDropdown(
                                  options: index == 0 || index == 2
                                      ? Constants.confirmation
                                      : Constants.verify,
                                  isExpanded: false,
                                  underLined: false,
                                  onChanged: (value) {
                                    switch (index) {
                                      case 0:
                                        cs1DmotPepsi = value;
                                        break;
                                      case 1:
                                        cS1ItdaPepsi = value;
                                        break;
                                      case 2:
                                        cS1ChitPepsi = value;
                                        break;
                                      case 3:
                                        cS1SaopPepsi = value;
                                        break;
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
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

  void onNextClick() {
    List<MarketVisitResponse> marketVisitResponseList = [];

    if (cs1DmotPepsi.isNotEmpty &&
        cS1ItdaPepsi.isNotEmpty &&
        cS1ChitPepsi.isNotEmpty &&
        cS1SaopPepsi.isNotEmpty) {
      marketVisitResponseList
          .add(MarketVisitResponse("CS", "CS_DT", cs1DmotPepsi));
      marketVisitResponseList
          .add(MarketVisitResponse("CS", "CS_IG", cS1ItdaPepsi));
      marketVisitResponseList
          .add(MarketVisitResponse("CS", "CS_CCT", cS1ChitPepsi));
      marketVisitResponseList
          .add(MarketVisitResponse("CS", "CS_SA", cS1SaopPepsi));
      controller.csDataSet(marketVisitResponseList);
    } else {
      showToastMessage("Please select Option");
    }
  }

  void setObservers() {
    ever(controller.cs1DataSaved, (aBoolean) {
      if (aBoolean) {
        //TODO-implement check for engro
        // if (config.getTenantId() == 2)

        Get.toNamed(Routes.stockInformation, arguments: [outletId, surveyType]);
      }
    });
  }
}

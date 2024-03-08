import 'package:eds_survey/ui/market_visit/coolers_verification/QuestionListItem.dart';
import 'package:eds_survey/ui/market_visit/stock_information/StockInformationScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/dropdowns/simple_dropdown.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class CoolerVerificationScreen extends StatelessWidget {
  CoolerVerificationScreen({super.key});

  final List<String> questions = [
    "Cooler Working",
    "Cooler at First/Prime Position",
    "Cooler Fullness",
    "Cooler Purity"
  ];

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
                            "PEPSI",
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
                        return CoolerQuestionListItem(text: questions[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => StockInformationScreen(),));
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

import 'package:eds_survey/ui/market_visit/coolers_verification/CoolerVerificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/dropdowns/simple_dropdown.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class CustomerServiceScreen extends StatelessWidget {
  CustomerServiceScreen({super.key});

  final List<String> questions = [
    "Is delivery made on time",
    "Is Invoice given by DM ?",
    "Are coolers and other complaints handled in time?",
    "Shopkeeper receiving Order SMS Alert"
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
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: CustomSimpleDropdownButton(
                                  options: ['Item1', 'Item2', 'Item3'],
                                  isExpanded: false,
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoolerVerificationScreen(),
                  ));
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

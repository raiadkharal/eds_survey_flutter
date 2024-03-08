import 'package:eds_survey/ui/market_visit/feedback/SurveyFeedbackScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/dropdowns/simple_dropdown.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class ExpiredStockScreen extends StatefulWidget {
  const ExpiredStockScreen({super.key});

  @override
  State<ExpiredStockScreen> createState() => _ExpiredStockScreenState();
}

class _ExpiredStockScreenState extends State<ExpiredStockScreen> {
  ExpiredStock? _selectedValue;

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
          height: MediaQuery
              .of(context)
              .size
              .height -
              (MediaQuery
                  .of(context)
                  .padding
                  .top +
                  AppBar().preferredSize.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          leading: Radio<ExpiredStock>(
                            value: ExpiredStock.yes,
                            activeColor: Colors.blueAccent,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "No",
                            style: GoogleFonts.roboto(color: Colors.black87),
                          ),
                          leading: Radio<ExpiredStock>(
                            value: ExpiredStock.no,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              setState(() {
                                _selectedValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (_selectedValue == ExpiredStock.yes)
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "1",
                                style: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: CustomSimpleDropdownButton(
                                      options: ['Item1', 'Item2', 'Item3'])),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: CustomSimpleDropdownButton(
                                      options: ['Item1', 'Item2', 'Item3'])),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 17.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Quantity",
                                          contentPadding: const EdgeInsets.only(
                                              top: 16, left: 10),
                                          hintStyle: GoogleFonts.roboto(
                                              color: Colors.black54,
                                              fontSize: 14)),
                                    ),
                                  ))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "2",
                                style: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: CustomSimpleDropdownButton(
                                      options: ['Item1', 'Item2', 'Item3'])),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: CustomSimpleDropdownButton(
                                      options: ['Item1', 'Item2', 'Item3'])),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 17.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Quantity",
                                        contentPadding: const EdgeInsets.only(
                                            top: 16, left: 10),
                                        hintStyle: GoogleFonts.roboto(
                                            color: Colors.black54,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "3",
                                style: GoogleFonts.roboto(
                                    color: Colors.black54, fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: CustomSimpleDropdownButton(
                                      options: ['Item1', 'Item2', 'Item3'])),
                              const SizedBox(
                                width: 10,
                              ),
                              const Expanded(
                                  child: CustomSimpleDropdownButton(
                                      options: ['Item1', 'Item2', 'Item3'])),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 17.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Quantity",
                                          contentPadding: const EdgeInsets.only(
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
                ),
              const Expanded(child: SizedBox()),
              CustomButton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const SurveyFeedbackScreen(),));
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
}

enum ExpiredStock { yes, no }

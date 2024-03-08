import 'package:eds_survey/ui/market_visit/customer_service/CustomerServiceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class GandolaScreen extends StatefulWidget {
  const GandolaScreen({super.key});

  @override
  State<GandolaScreen> createState() => _GandolaScreenState();
}

class _GandolaScreenState extends State<GandolaScreen> {
  Gandola? _selectedValue;
  String? _selectedIntegrity;
  final List<String> _integrityList = [
    "0-20%",
    "21-40%",
    "41-60%",
    "61-80%",
    "81-100%"
  ];

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
                    ListTile(
                      title: Text(
                        "Yes",
                        style: GoogleFonts.roboto(color: Colors.black87),
                      ),
                      leading: Radio<Gandola>(
                        value: Gandola.yes,
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
                      leading: Radio<Gandola>(
                        value: Gandola.no,
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Gandola Integrity
          if (_selectedValue == Gandola.yes)
            Expanded(
              flex: 3,
              child: Padding(
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
                                  style:
                                  GoogleFonts.roboto(color: Colors.black87),
                                ),
                                leading: Radio<String>(
                                  value: _integrityList[index],
                                  activeColor: Colors.blueAccent,
                                  groupValue: _selectedIntegrity,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedIntegrity = value;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          const Expanded(child: SizedBox()),
          CustomButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CustomerServiceScreen(),));
            },
            text: "Next",
            enabled: true,
            fontSize: 22,
            horizontalPadding: 10,
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}

enum Gandola { yes, no }

import 'package:eds_survey/ui/market_visit/expired_stock/ExpiredStockScreen.dart';
import 'package:eds_survey/ui/market_visit/stock_information/CheckListItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class StockInformationScreen extends StatelessWidget {
  StockInformationScreen({super.key});

  final List<String> skus = [
    "250ml RB",
    "250ml CAN",
    "300ml Can",
    "345ml",
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
              child: Container(
                color: Colors.grey.shade200,
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CheckListItem(index: index, skuList: skus);
                  },
                ),
              )),
          CustomButton(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ExpiredStockScreen(),));
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

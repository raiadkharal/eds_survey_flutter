import 'package:eds_survey/ui/outlet/outlet_list/OutletListItem.dart';
import 'package:eds_survey/ui/outlet/summary/OutletSummaryScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class OutletListScreen extends StatelessWidget {
  const OutletListScreen({super.key});

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
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "OUTLET LIST",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 50,
              itemBuilder: (context, index) {
                return OutletListItem(onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const OutletSummaryScreen(),));
                },);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.grey,
                  height: 0.5,
                  width: double.infinity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

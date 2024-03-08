import 'package:eds_survey/components/textfields/custom_text_field.dart';
import 'package:eds_survey/ui/work_with/execution_standards/QuestionListItem.dart';
import 'package:eds_survey/ui/work_with/steps_of_call/StepsOfCallListItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class RemarksScreen extends StatelessWidget {
  const RemarksScreen({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "REMARKS",
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
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: Colors.grey.shade300,
                  hintText: "Total( For 8 Steps Of Call)",
                  hintStyle: GoogleFonts.roboto(color: Colors.blueAccent)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.all(16),
                  fillColor: Colors.grey.shade300,
                  hintText: "Total( For Execution Standards)",
                  hintStyle: GoogleFonts.roboto(color: Colors.blueAccent)),
            ),
          ),
          const Expanded(child: SizedBox()),
          CustomButton(
            onTap: () {},
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
}

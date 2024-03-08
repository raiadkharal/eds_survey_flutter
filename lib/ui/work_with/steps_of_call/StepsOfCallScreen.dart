import 'package:eds_survey/ui/work_with/execution_standards/QuestionListItem.dart';
import 'package:eds_survey/ui/work_with/steps_of_call/StepsOfCallListItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class StepOfCallScreen extends StatelessWidget {
  const StepOfCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> questionsList = [
      "Prepare for Call",
      "Greet the Customer",
      "Stock check",
      "Merchandising",
      "Suggest the order",
      "Presentation",
      "Curbside DE-Brief",
      "Confirm Order",
    ];
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
              "8 STEPS OF THE CALL",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: questionsList.length,
            itemBuilder: (context, index) {
              return StepsCallListItem(
                text: questionsList[index],
              );
            },
          )),
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

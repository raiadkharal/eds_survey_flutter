import 'package:eds_survey/ui/work_with/execution_standards/QuestionListItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class ExecutionStandards extends StatelessWidget {
  const ExecutionStandards({super.key});

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
              "EXECUTION STANDARDS",
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
            itemCount: 5,
            itemBuilder: (context, index) {
              return QuestionListItem(text: questionsList[index],);
            },
          )),
          const Expanded(child: SizedBox()),
          CustomButton(
            onTap: () {},
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

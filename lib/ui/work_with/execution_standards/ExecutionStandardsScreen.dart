import 'package:eds_survey/Route.dart';
import 'package:eds_survey/data/MarketVisitResponse.dart';
import 'package:eds_survey/ui/work_with/execution_standards/ExecutionStandardsViewModel.dart';
import 'package:eds_survey/ui/work_with/execution_standards/QuestionListItem.dart';
import 'package:eds_survey/ui/work_with/remarks/RemarksScreen.dart';
import 'package:eds_survey/ui/work_with/steps_of_call/StepsOfCallScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/button/CustomButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Enums.dart';

class ExecutionStandardsScreen extends StatefulWidget {
  const ExecutionStandardsScreen({super.key});

  @override
  State<ExecutionStandardsScreen> createState() => _ExecutionStandardsScreenState();
}

class _ExecutionStandardsScreenState extends State<ExecutionStandardsScreen> {
  final ExecutionStandardsViewModel controller =
      Get.put(ExecutionStandardsViewModel());

  late final SurveyType surveyType;
  late final int outletId;


  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    setObservers();

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
                itemCount: controller.questionList.length,
                itemBuilder: (context, index) {
                  return QuestionListItem(
                    text: controller.questionList[index],
                    onChanged: (value) {
                      if (value == Verify.yes) {
                        controller.addResponse(index, "YES");
                      } else if (value == Verify.no) {
                        controller.addResponse(index, "NO");
                      } else {
                        controller.addResponse(index, null);
                      }
                    },
                  );
                },
              ),
              ),
          CustomButton(
            onTap:() => controller.onNextClick(),
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

  void setObservers() {
    ever(controller.navigate, (aBoolean) async {
      if (aBoolean) {
        final result = await Get.toNamed(Routes.stepsOfCall,arguments: [outletId,surveyType]);

        if(result=="ok"){
          Get.back(result: result);
        }

      }
    });
  }
}

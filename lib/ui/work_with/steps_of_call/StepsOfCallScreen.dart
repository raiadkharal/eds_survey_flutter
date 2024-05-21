import 'package:eds_survey/Route.dart';
import 'package:eds_survey/ui/work_with/execution_standards/ExecutionStandardsScreen.dart';
import 'package:eds_survey/ui/work_with/execution_standards/QuestionListItem.dart';
import 'package:eds_survey/ui/work_with/remarks/RemarksScreen.dart';
import 'package:eds_survey/ui/work_with/steps_of_call/StepsOfCallListItem.dart';
import 'package:eds_survey/ui/work_with/steps_of_call/StepsOfCallViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';

import '../../../components/button/CustomButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Enums.dart';

class StepOfCallScreen extends StatefulWidget {

  const StepOfCallScreen({super.key});

  @override
  State<StepOfCallScreen> createState() => _StepOfCallScreenState();
}

class _StepOfCallScreenState extends State<StepOfCallScreen> {
  final StepsOfCallViewModel controller = Get.put(StepsOfCallViewModel());

  late final SurveyType surveyType;
  late final int outletId;
  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];

    setObservers();

    super.initState();
  }
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
            itemCount: controller.questionsList.length,
            itemBuilder: (context, index) {
              return StepsCallListItem(
                text: controller.questionsList[index],
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
          )),
          CustomButton(
            onTap: () => controller.validate(),
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
    debounce(controller.navigate, (aBoolean){
      if(aBoolean) {
        Get.toNamed(Routes.remarks,arguments: [outletId,surveyType]);
      }
    },time: const Duration(milliseconds: 200));
  }
}

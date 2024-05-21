import 'package:eds_survey/components/textfield/CustomTextField.dart';
import 'package:eds_survey/ui/market_visit/feedback/SurveyFeedbackScreen.dart';
import 'package:eds_survey/ui/work_with/execution_standards/QuestionListItem.dart';
import 'package:eds_survey/ui/work_with/remarks/RemarksViewModel.dart';
import 'package:eds_survey/ui/work_with/steps_of_call/StepsOfCallListItem.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';

import '../../../Route.dart';
import '../../../components/button/CustomButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../utils/Colors.dart';

class RemarksScreen extends StatefulWidget {

  const RemarksScreen({super.key});

  @override
  State<RemarksScreen> createState() => _RemarksScreenState();
}

class _RemarksScreenState extends State<RemarksScreen> {
  final RemarksViewModel controller = Get.put(RemarksViewModel());

  late final SurveyType surveyType;
  late final int outletId;

  final TextEditingController _stcController =
      TextEditingController(text: "0.0/8.0");

  final TextEditingController _esController =
      TextEditingController(text: "0.0/7.0");

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];

    setObservers();
    controller.getTotal();
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
            child:TextField(
                controller: _stcController,
                style: GoogleFonts.roboto(color: Colors.black87),
                decoration: InputDecoration(
                    filled: true,
                    enabled: false,
                    contentPadding: const EdgeInsets.all(8.0),
                    fillColor: Colors.grey.shade300,
                    label: const Text("Total( For 8 Steps Of Call)"),
                    labelStyle: GoogleFonts.roboto(color: Colors.blueAccent)),
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:  TextField(
                controller: _esController,
                style: GoogleFonts.roboto(color: Colors.black87),
                decoration: InputDecoration(
                    filled: true,
                    enabled: false,
                    contentPadding: const EdgeInsets.all(8.0),
                    fillColor: Colors.grey.shade300,
                    label: const Text("Total( For Execution Standards)"),
                    labelStyle: GoogleFonts.roboto(color: Colors.blueAccent)),
              ),
          ),
          const Expanded(child: SizedBox()),
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
    debounce(controller.navigate, (aBoolean) {
      if (aBoolean) {
        Get.toNamed(Routes.surveyFeedback, arguments: [
          outletId,
          surveyType
        ]);
      }
    },time: const Duration(milliseconds: 200));

    debounce(controller.stc, (total) => _stcController.text = total,time: const Duration(milliseconds: 200));
    debounce(controller.es, (total) => _esController.text = total,time: const Duration(milliseconds: 200));
  }
}

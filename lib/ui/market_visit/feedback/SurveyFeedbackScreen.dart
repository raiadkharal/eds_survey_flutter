import 'dart:convert';
import 'dart:typed_data';

import 'package:eds_survey/Route.dart';
import 'package:eds_survey/data/SurveySingletonModel.dart';
import 'package:eds_survey/data/WorkWithSingletonModel.dart';
import 'package:eds_survey/ui/login/LoginScreen.dart';
import 'package:eds_survey/ui/market_visit/feedback/SurveyFeedbackViewModel.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletsScreen.dart';
import 'package:eds_survey/ui/priorities/PrioritiesScreen.dart';
import 'package:eds_survey/ui/signature_pad/SignatureScreen.dart';
import 'package:eds_survey/utils/AlertDialogManager.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/button/CustomButton.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../components/progress_dialog/PregressDialog.dart';
import '../../../utils/Colors.dart';
import '../../../utils/Utils.dart';

class SurveyFeedbackScreen extends StatefulWidget {
  const SurveyFeedbackScreen({super.key});

  @override
  State<SurveyFeedbackScreen> createState() => _SurveyFeedbackScreenState();
}

class _SurveyFeedbackScreenState extends State<SurveyFeedbackScreen> {
  final SurveyFeedbackViewModel controller =
      Get.put(SurveyFeedbackViewModel(Get.find()));

  final feedbackController = TextEditingController();

  late final SurveyType surveyType;
  late final int outletId;

  String signature = "";

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];

    setObservers();

    super.initState();
  }

  void _navigateToSignatureScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignatureScreen()),
    );

    // Handle the result received from Screen B
    if (result != null) {
      Uint8List imageFile = Uint8List.fromList(result);
      controller.setSignatureImage(imageFile);
      signature = base64Encode(imageFile);
    }
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).padding.top +
                  AppBar().preferredSize.height),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "SURVEY FEEDBACK",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Feedback",
                          style: GoogleFonts.roboto(
                              color: Colors.grey.shade800,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: SizedBox(
                            height: 120,
                            child: TextField(
                              minLines: 3,
                              controller: feedbackController,
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: null,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Add feedback here",
                                  hintStyle: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                  focusColor: Colors.grey,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.grey)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                          color: Colors.grey))),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Customer Signature",
                              style: GoogleFonts.roboto(
                                  color: Colors.grey.shade800,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _navigateToSignatureScreen();
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.pen,
                                  size: 16,
                                )),
                          ],
                        ),

                        //signature Imageview
                        Container(
                          height: 150.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color:
                                  Colors.grey, // Adjust border color as needed
                            ),
                            borderRadius: BorderRadius.circular(
                                5.0), // Adjust border radius as needed
                          ),
                          child: Obx(() {
                            return controller.signatureImage.value!.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Image.memory(
                                        controller.signatureImage.value!))
                                : Container();
                          }),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomButton(
                    onTap: () {
                      onNextClick(context);
                    },
                    text: surveyType == SurveyType.MARKET_VISIT
                        ? "Finish"
                        : "Next",
                    enabled: true,
                    fontSize: 22,
                    horizontalPadding: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              Obx(
                () => controller.isLoading().value
                    ? const SimpleProgressDialog()
                    : const SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onNextClick(BuildContext context) async {
    //remove focus from feedback textField
    FocusScope.of(context).requestFocus(FocusNode());

    if (SurveySingletonModel.getInstance().getOutletId() == null ||
        SurveySingletonModel.getInstance().getOutletId() == 0) {
      //Low memory dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Low Memory Resources"),
          content: const Text(
              "Your device memory is running low. Please click ok to refresh"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  return;
                },
                child: const Text("Ok"))
          ],
        ),
      );
      return;
    }

    //TODO-add signature null check here
    if(signature.isEmpty){
      showToastMessage("Signature field is missing");
      return;
    }

    if (surveyType == SurveyType.MARKET_VISIT) {
      //verification dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Finish Survey!"),
          content: const Text(
              "Are you sure you want to complete the survey for this outlet?"),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                return;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No",
                  style: GoogleFonts.roboto(
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                try {
                  String feedBack = feedbackController.text;
                  SurveySingletonModel.getInstance().setFeedBack(feedBack);
                  SurveySingletonModel.getInstance()
                      .setCustomerSignature(signature);
                  Navigator.of(context).pop();
                  controller.saveSurvey();
                } catch (e) {
                  showToastMessage(
                      "Something went Wrong.Please try again later");
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Yes",
                  style: GoogleFonts.roboto(
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      try {
        String feedBack = feedbackController.text;
        WorkWithSingletonModel.getInstance().setFeedback(feedBack);
        WorkWithSingletonModel.getInstance().setCustomerSignature(signature);

        final result = await Get.toNamed(Routes.priorities, arguments: [outletId, surveyType]);

        if(result=="ok"){
          Get.back(result: result);
        }

      } catch (e) {
        showToastMessage("Something went Wrong.Please try again later");
      }
    }
  }

  void setObservers() {
    debounce(controller.isSurveySaved(), (aBoolean) {
      if (aBoolean) {
        // Get.back(result: "ok");
        Get.until((route) => Get.currentRoute==Routes.outletList);
        SurveySingletonModel.getInstance().reset();
      }
    }, time: const Duration(milliseconds: 1000));

    debounce(controller.getMessage(), (event) {
      showToastMessage(event.peekContent());
    }, time: const Duration(milliseconds: 200));
  }
}

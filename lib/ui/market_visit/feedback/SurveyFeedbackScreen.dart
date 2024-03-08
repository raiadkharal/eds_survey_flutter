import 'dart:typed_data';

import 'package:eds_survey/ui/signature_pad/SignatureScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Colors.dart';

class SurveyFeedbackScreen extends StatefulWidget {
  const SurveyFeedbackScreen({super.key});

  @override
  State<SurveyFeedbackScreen> createState() => _SurveyFeedbackScreenState();
}

class _SurveyFeedbackScreenState extends State<SurveyFeedbackScreen> {
  Uint8List? _signatureImage;

  void _navigateToSignatureScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignatureScreen()),
    );

    // Handle the result received from Screen B
    if (result != null) {
      setState(() {
        _signatureImage = Uint8List.fromList(result);
      });
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
              (MediaQuery.of(context).padding.top+AppBar().preferredSize.height),
          child: Column(
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
                                  borderSide: const BorderSide(color: Colors.grey)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey))),
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
                          color: Colors.grey, // Adjust border color as needed
                        ),
                        borderRadius: BorderRadius.circular(
                            5.0), // Adjust border radius as needed
                      ),
                      child: _signatureImage != null
                          ? Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Image.memory(_signatureImage!))
                          : Container(),
                    ),
                  ],
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
        ),
      ),
    );
  }
}

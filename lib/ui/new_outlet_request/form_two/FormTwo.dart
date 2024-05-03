import 'dart:io';
import 'dart:typed_data';

import 'package:eds_survey/ui/new_outlet_request/form_two/FormTwoViewModel.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/dropdowns/SimpleDropdownButton.dart';
import '../../../components/textfields/UnderlinedTextField.dart';
import '../../signature_pad/SignatureScreen.dart';

class FormTwo extends StatefulWidget {
  FormTwo({super.key});

  @override
  State<FormTwo> createState() => _FormTwoState();
}

class _FormTwoState extends State<FormTwo> {
  final FormTwoViewModel controller =
      Get.put<FormTwoViewModel>(FormTwoViewModel());
  final List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Expanded(
            child: Card(
              color: Colors.white,
              elevation: 2,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(bottom: 26.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const UnderlinedTextField(
                          hintText: 'Owner Name',
                        ),
                        const UnderlinedTextField(
                          hintText: 'Owner Father Name',
                        ),
                        const UnderlinedTextField(
                          hintText: 'CNIC',
                        ),
                        const UnderlinedTextField(
                          hintText: 'Contact Person Phone',
                          helperText: Constants.PHONE_NUMBER_HELPER_TEXT,
                        ),
                        const UnderlinedTextField(
                          hintText: 'Contact Person',
                        ),
                        const UnderlinedTextField(
                          hintText: 'Contact Person 1 Phone',
                          helperText: Constants.PHONE_NUMBER_HELPER_TEXT,
                        ),
                        const UnderlinedTextField(
                          hintText: 'Contact Person 2',
                        ),
                        const UnderlinedTextField(
                          hintText: 'Contact Person 2 Phone',
                          helperText: Constants.PHONE_NUMBER_HELPER_TEXT,
                        ),
                        const UnderlinedTextField(
                          hintText: 'Contact Person 3',
                        ),
                        const UnderlinedTextField(
                          hintText: 'Contact Person 3 Phone',
                          helperText: Constants.PHONE_NUMBER_HELPER_TEXT,
                        ),
                        ImageSectionView(
                          text: 'CNIC Front Image',
                          iconData: Icons.camera_alt,
                          onIconClick: () =>
                              showToastMessage("Cnic Front Image"),
                        ),
                        ImageSectionView(
                          text: 'CNIC Back Image',
                          iconData: Icons.camera_alt,
                          onIconClick: () =>
                              showToastMessage("Cnic Back image"),
                        ),
                        Obx(
                          () => ImageSectionView(
                            text: 'E-Signature',
                            iconData: Icons.edit,
                            termsAndConditions: "Terms and Conditions",
                            imageFile: controller.signatureImage.value,
                            onIconClick: () => _navigateToSignatureScreen(),
                          ),
                        ),
                        ImageSectionView(
                          text: 'Outlet Image',
                          iconData: Icons.camera_alt,
                          onIconClick: () => showToastMessage("Outlet Image"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                  width: 8,
                  height: 8,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                  width: 8,
                  height: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
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
      // signature = base64Encode(imageFile);
    }
  }
}

class ImageSectionView extends StatelessWidget {
  final String text;
  final dynamic imageFile;
  final IconData iconData;
  final VoidCallback onIconClick;
  final String? termsAndConditions;

  const ImageSectionView(
      {super.key,
      required this.text,
      this.imageFile,
      required this.iconData,
      required this.onIconClick,
      this.termsAndConditions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              text,
              style: GoogleFonts.roboto(color: Colors.grey),
            ),
            IconButton(onPressed: onIconClick, icon: Icon(iconData)),
            Text(
              termsAndConditions ?? "",
              style: GoogleFonts.roboto(color: Colors.red),
            )
          ],
        ),

        //ImageView
        Container(
          height: 150.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey, // Adjust border color as needed
            ),
            borderRadius:
                BorderRadius.circular(5.0), // Adjust border radius as needed
          ),
          child: imageFile != null
              ? Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: imageFile is Uint8List
                      ? (imageFile as Uint8List).isNotEmpty
                          ? Image.memory(imageFile)
                          : Container()
                      : Image.file(
                          imageFile!,
                          fit: BoxFit.fill,
                        ))
              : Container(),
        ),
      ],
    );
  }
}

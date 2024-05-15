import 'package:eds_survey/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderlinedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? helperText;
  final int? maxLength;
  final bool enabled;
 final TextInputType keyboardType;
  final Function(String)? validator;

  const UnderlinedTextField(
      {super.key,
      required this.hintText,
      this.helperText,
      this.maxLength,
      required this.controller,
      this.validator, this.keyboardType=TextInputType.text, this.enabled=true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        enabled: enabled,
        keyboardType: keyboardType,
        cursorColor: Colors.black,
        validator: (value) => validator != null ? validator!(value!) : null,
        decoration: InputDecoration(
            border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            hintText: hintText,
            helperText: helperText,
            hintStyle: GoogleFonts.roboto(color: Colors.black54)),
      ),
    );
  }
}

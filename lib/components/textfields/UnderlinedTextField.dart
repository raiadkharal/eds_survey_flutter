import 'package:eds_survey/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderlinedTextField extends StatelessWidget {
  final String hintText;
  final String? helperText;

  const UnderlinedTextField(
      {super.key, required this.hintText, this.helperText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: TextField(
        cursorColor: Colors.black,
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

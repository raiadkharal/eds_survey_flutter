
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageSectionView extends StatelessWidget {
  final String text;
  final File imageFile;
  final IconData iconData;
  final VoidCallback onIconClick;
  final String? termsAndConditions;

  const ImageSectionView(
      {super.key,
        required this.text,
        required this.imageFile,
        required this.iconData,
        required this.onIconClick,
        this.termsAndConditions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          height: 200.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: imageFile.path.isEmpty
              ? Container()
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
              imageFile,
            ),
          ),
        ),
       /* Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: const Text("Error Text here",style: TextStyle(color: Color.fromARGB(255, 200, 0, 0),fontSize: 12),textAlign: TextAlign.start,),
        )*/
      ],
    );
  }
}
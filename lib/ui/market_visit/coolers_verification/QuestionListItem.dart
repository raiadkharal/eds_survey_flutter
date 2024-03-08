import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/dropdowns/simple_dropdown.dart';
import '../../../utils/Colors.dart';

class CoolerQuestionListItem extends StatelessWidget {
  final String text;

  const CoolerQuestionListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              text,
              style: GoogleFonts.roboto(
                  color: primaryColor,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomSimpleDropdownButton(
              options: ['Item1', 'Item2', 'Item3'],
              isExpanded: false,
            ),
          )
        ],
      ),
    );
  }
}

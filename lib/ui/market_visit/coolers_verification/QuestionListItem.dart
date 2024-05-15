import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/dropdowns/SimpleDropdownButton.dart';
import '../../../utils/Colors.dart';

class CoolerQuestionListItem extends StatelessWidget {
  final String text;
  final List<String> options;
  final Function(dynamic)? onChanged;

  const CoolerQuestionListItem({super.key, required this.text, required this.options, this.onChanged});

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SimpleDropdownButton(
              options: options,
              isExpanded: false,
              borderOutlined: false,
              onChanged: onChanged,
            ),
          )
        ],
      ),
    );
  }
}

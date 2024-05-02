import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Enums.dart';
import '../execution_standards/QuestionListItem.dart';

class StepsCallListItem extends StatefulWidget {
  final String text;
  final Function(Verify) onChanged;
  const StepsCallListItem({super.key, required this.text, required this.onChanged});

  @override
  State<StepsCallListItem> createState() => _StepsCallListItemState();
}

class _StepsCallListItemState extends State<StepsCallListItem> {
  Verify? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 230,
            child: Text(
             widget.text
            ),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<Verify>(
                    value: Verify.yes,
                    activeColor: Colors.blueAccent,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                      widget.onChanged(value!);
                    },
                  ),
                  Text(
                    "Y",
                    style: GoogleFonts.roboto(color: Colors.black87),
                  ),
                ],
              ),
              Row(
                children: [
                  Radio<Verify>(
                    value: Verify.no,
                    activeColor: Colors.blueAccent,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                      widget.onChanged(value!);
                    },
                  ),
                  Text(
                    "N",
                    style: GoogleFonts.roboto(color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

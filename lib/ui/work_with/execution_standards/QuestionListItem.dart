import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionListItem extends StatefulWidget {
  final String text;

  const QuestionListItem({super.key, required this.text});

  @override
  State<QuestionListItem> createState() => _QuestionListItemState();
}

class _QuestionListItemState extends State<QuestionListItem> {
  Options? _selectedValue;

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
            child: Text(widget.text),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<Options>(
                    value: Options.yes,
                    activeColor: Colors.blueAccent,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
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
                  Radio<Options>(
                    value: Options.no,
                    activeColor: Colors.blueAccent,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
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

enum Options { yes, no }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Enums.dart';

class QuestionListItem extends StatefulWidget {
  final String text;
  final Function(Verify) onChanged;

  const QuestionListItem({super.key, required this.onChanged, required this.text});

  @override
  State<QuestionListItem> createState() => _QuestionListItemState();
}

class _QuestionListItemState extends State<QuestionListItem> {
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
                child: Text(widget.text),
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

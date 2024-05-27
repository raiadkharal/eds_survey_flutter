import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerServiceDropdown extends StatefulWidget {
  final List<String> options;
  final bool isExpanded;
  final bool underLined;
  final Function(String)? onChanged;
  final String hint;
  final bool enabled;

  const CustomerServiceDropdown(
      {super.key,
        required this.options,
        this.isExpanded = true,
        this.underLined = true,
        this.enabled = true,
        this.onChanged,
        this.hint = ""});

  @override
  State<CustomerServiceDropdown> createState() =>
      _SimpleDropdownButtonState();
}

class _SimpleDropdownButtonState extends State<CustomerServiceDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      alignment: AlignmentDirectional.centerEnd,
      isExpanded: widget.isExpanded,
      hint: Text(
        widget.hint,
        style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
      ),
      underline: widget.underLined
          ? Container(
        color: Colors.grey,
        height: 1,
      )
          : const SizedBox(),
      items: widget.options.map((option) {
        return DropdownMenuItem(
            enabled: widget.enabled,
            value: option,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                option,
                style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
              ),
            ));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value!);
        }
      },
    );
  }
}

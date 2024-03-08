import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlineCustomDropDownMenu extends StatefulWidget {
  final List<String> options;
  final bool isExpanded;
  final bool underLined;

  const OutlineCustomDropDownMenu(
      {super.key,
      required this.options,
      this.isExpanded = true,
      this.underLined = true});

  @override
  State<OutlineCustomDropDownMenu> createState() =>
      _OutlineCustomDropDownMenuState();
}

class _OutlineCustomDropDownMenuState extends State<OutlineCustomDropDownMenu> {
  late String selectedValue = widget.options.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isDense: true,
      value: selectedValue,
      isExpanded: widget.isExpanded,
      items: widget.options.map((option) {
        return DropdownMenuItem(
            value: option,
            child: Text(
              option,
              style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
            ));
      }).toList(),
      decoration: const InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusColor: Colors.grey,
          isDense: true,
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          contentPadding: EdgeInsets.all(8.0)),
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
      },
    );
  }
}

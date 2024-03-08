import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSimpleDropdownButton extends StatefulWidget {
  final List<String> options;
  final bool isExpanded;
  final bool underLined;

  const CustomSimpleDropdownButton(
      {super.key,
      required this.options,
      this.isExpanded = true,
      this.underLined = true});

  @override
  State<CustomSimpleDropdownButton> createState() =>
      _CustomSimpleDropdownButtonState();
}

class _CustomSimpleDropdownButtonState
    extends State<CustomSimpleDropdownButton> {
  late String selectedValue = widget.options.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      isExpanded: widget.isExpanded,
      underline: Container(color: Colors.grey,height: 1,),
      items: widget.options.map((option) {
        return DropdownMenuItem(
            value: option,
            child: Text(
              option,
              style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
            ));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
      },
    );
  }
}

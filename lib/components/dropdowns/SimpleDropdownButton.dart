import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleDropdownButton extends StatefulWidget {
  final List<String> options;
  final bool isExpanded;
  final double textSize;
  final String? hintText;
  final bool borderOutlined;
  final Function(String)? onChanged;

  const SimpleDropdownButton(
      {super.key,
      required this.options,
      this.isExpanded = true,
      this.borderOutlined = true,
      this.onChanged, this.textSize=14.0, this.hintText});

  @override
  State<SimpleDropdownButton> createState() => _SimpleDropdownExpiredStockState();
}

class _SimpleDropdownExpiredStockState extends State<SimpleDropdownButton> {
  late String selectedValue = widget.options.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      alignment: AlignmentDirectional.centerEnd,
      isExpanded: widget.isExpanded,
      items: widget.options.map((option) {
        return DropdownMenuItem(
            alignment: AlignmentDirectional.centerStart,
            value: option,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                option,
                style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
              ),
            ));
      }).toList(),
      decoration: InputDecoration(
        hintText: widget.hintText??"",
          hintStyle: GoogleFonts.roboto(
              color: Colors.black54),
          focusedBorder: widget.borderOutlined?
          const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)):InputBorder.none,
          focusColor: Colors.grey,
          isDense: true,
          border: widget.borderOutlined?
          const UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)):InputBorder.none,),
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

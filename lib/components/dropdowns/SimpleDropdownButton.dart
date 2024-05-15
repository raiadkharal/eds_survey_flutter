import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleDropdownButton extends StatefulWidget {
  final List<dynamic> options;
  final bool isExpanded;
  final double textSize;
  final String? hintText;
  final String? errorText;
  final bool borderOutlined;
  final Function(dynamic)? onChanged;
  final Function(String?)? validator;

  const SimpleDropdownButton(
      {super.key,
      required this.options,
      this.isExpanded = true,
      this.borderOutlined = true,
      this.onChanged,
      this.textSize = 14.0,
      this.hintText,
      this.errorText,
      this.validator});

  @override
  State<SimpleDropdownButton> createState() =>
      _SimpleDropdownExpiredStockState();
}

class _SimpleDropdownExpiredStockState extends State<SimpleDropdownButton> {
  // late dynamic selectedValue = widget.options.first;

  @override
  Widget build(BuildContext context) {
    late final List<dynamic> options;
    if (widget.options.first is LookUpObject) {
      options = widget.options as List<LookUpObject>;
    } else if (widget.options.first is String) {
      options = widget.options as List<String>;
    }
    return DropdownButtonFormField<dynamic>(
      alignment: AlignmentDirectional.centerEnd,
      isExpanded: widget.isExpanded,
      validator: (value) => widget.validator != null
          ? (value != null
              ? widget.validator!((value as LookUpObject).value)
              : widget.validator!(null))
          : null,
      items: options.map((option) {
        return DropdownMenuItem(
            alignment: AlignmentDirectional.centerStart,
            value: option,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                options.first is LookUpObject
                    ? (option as LookUpObject).value
                    : option,
                style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
              ),
            ));
      }).toList(),
      decoration: InputDecoration(
        hintText: widget.hintText ?? "",
        errorText: widget.errorText,
        hintStyle: GoogleFonts.roboto(color: Colors.black54),
        focusedBorder: widget.borderOutlined
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))
            : InputBorder.none,
        focusColor: Colors.grey,
        isDense: true,
        border: widget.borderOutlined
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey))
            : InputBorder.none,
      ),
      onChanged: (value) {
        // setState(() {
        //   selectedValue = value!;
        // });
        if (widget.onChanged != null) {
          if (value != null) {
            widget.onChanged!(value);
          }
        }
      },
    );
  }
}

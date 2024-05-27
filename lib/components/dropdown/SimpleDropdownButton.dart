import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/data/models/outlet_request/LookUpDataObject.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleDropdownButton extends StatefulWidget {
  final List<dynamic> options;
  final bool isExpanded;
  final double textSize;
  final String? labelText;
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
      this.labelText,
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
    List<dynamic> options=[];
    if (widget.options.first is LookUpDataObject) {
      options = widget.options as List<LookUpDataObject>;
    } else if (widget.options.first is String) {
      options = widget.options as List<String>;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: DropdownButtonFormField<dynamic>(
        alignment: AlignmentDirectional.centerEnd,
        isExpanded: widget.isExpanded,
        validator: (value) => widget.validator != null
            ? (value != null
                ? widget.validator!((value as LookUpDataObject).value)
                : widget.validator!(null))
            : null,
        items: options.map((option) {
          return DropdownMenuItem(
              alignment: AlignmentDirectional.centerStart,
              value: option,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  options.first is LookUpDataObject
                      ? (option as LookUpDataObject).value
                      : option,
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 16),
                ),
              ));
        }).toList(),
        decoration: InputDecoration(
          labelText: widget.labelText,
          errorText: widget.errorText,
          labelStyle: GoogleFonts.roboto(color: Colors.black54),
          focusedBorder: widget.borderOutlined
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))
              : InputBorder.none,
          focusColor: Colors.grey,
          border: widget.borderOutlined
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))
              : InputBorder.none,
        ),
        onChanged: (value) {
          if (widget.onChanged != null) {
            if (value != null) {
              widget.onChanged!(value);
            }
          }
        },
      ),
    );
  }
}

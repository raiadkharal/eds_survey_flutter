import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleDropdownExpiredStock extends StatefulWidget {
  final List<LookUpObject> options;
  final bool isExpanded;
  final bool underLined;
  final Function(LookUpObject)? onChanged;
  final String hint;
  final bool enabled;

  const SimpleDropdownExpiredStock(
      {super.key,
      required this.options,
      this.isExpanded = true,
      this.underLined = true,
      this.enabled = true,
      this.onChanged,
      this.hint = ""});

  @override
  State<SimpleDropdownExpiredStock> createState() =>
      _SimpleDropdownButtonState();
}

class _SimpleDropdownButtonState extends State<SimpleDropdownExpiredStock> {
  LookUpObject? selectedValue;

  @override
  void initState() {
    selectedValue = widget.hint.isEmpty ? widget.options.first : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.enabled) {
          showToastMessage("Select Package");
        }
      },
      child: DropdownButtonFormField<LookUpObject>(
        value: selectedValue,
        isExpanded: widget.isExpanded,
        isDense: true,
        menuMaxHeight: 400,
        hint: Text(
          widget.hint,
          style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
        ),
        items: widget.options.map((option) {
          return DropdownMenuItem(
              enabled: widget.enabled,
              value: option,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                option.value ?? "",
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
              ));
        }).toList(),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: GoogleFonts.roboto(color: Colors.black54),
          focusedBorder: widget.underLined
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))
              : InputBorder.none,
          focusColor: Colors.grey,
          border: widget.underLined
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))
              : InputBorder.none,
        ),
        onChanged: widget.enabled
            ? (value) {
                // setState(() {
                //   selectedValue = value!;
                // });
                if (widget.onChanged != null) {
                  widget.onChanged!(value!);
                }
              }
            : null,
      ),
    );
  }
}

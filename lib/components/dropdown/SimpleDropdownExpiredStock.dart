import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
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
 late LookUpObject selectedValue = widget.options.first;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.enabled) {
          showToastMessage("Select Package");
        }
      },
      child: DropdownButton<LookUpObject>(
        value: selectedValue,
        isExpanded: widget.isExpanded,
        isDense: true,
        menuMaxHeight: 400,
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
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                option.value?? "",
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14),
              ));
        }).toList(),
        onChanged: widget.enabled
            ? (value) {
                setState(() {
                  selectedValue = value!;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value!);
                }
              }
            : null,
      ),
    );
  }
}

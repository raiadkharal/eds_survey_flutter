import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleDropdownButton extends StatefulWidget {
  final List<String> options;
  final bool isExpanded;
  final bool underLined;
  final Function(String)? onChanged;

  const SimpleDropdownButton(
      {super.key,
      required this.options,
      this.isExpanded = true,
      this.underLined = true,
      this.onChanged});

  @override
  State<SimpleDropdownButton> createState() => _SimpleDropdownExpiredStockState();
}

class _SimpleDropdownExpiredStockState extends State<SimpleDropdownButton> {
  late String selectedValue = widget.options.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      alignment: AlignmentDirectional.centerEnd,
      value: selectedValue,
      isExpanded: widget.isExpanded,
      underline: widget.underLined
          ? Container(
              color: Colors.grey,
              height: 1,
            )
          : const SizedBox(),
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

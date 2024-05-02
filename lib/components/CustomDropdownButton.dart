import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final String Function(T)? displayValue;
  final void Function(T?) onChanged;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.value,
    required this.displayValue,
    required this.onChanged,
  });

  @override
  State<CustomDropdownButton<T>> createState() => _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  late dynamic selectedValue=widget.value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: selectedValue,
      isExpanded: true,
      items: widget.items.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(widget.displayValue?.call(item) ?? ''),
        );
      }).toList(),
      onChanged: (value){

        setState(() {
        selectedValue=value;
        });

        widget.onChanged(value);
      },
    );
  }
}

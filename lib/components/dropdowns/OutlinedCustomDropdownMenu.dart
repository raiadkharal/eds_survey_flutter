import 'package:eds_survey/data/db/entities/task_type.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/db/entities/workwith/WTaskType.dart';

class OutlineCustomDropDownMenu extends StatefulWidget {
  final List<dynamic> options;
  final bool isExpanded;
  final bool underLined;
  final SurveyType surveyType;
  final dynamic selectedValue;
  final Function(dynamic) onChanged;

  const OutlineCustomDropDownMenu(
      {super.key,
      required this.options,
      this.isExpanded = true,
      this.underLined = true, required this.onChanged, required this.selectedValue, required this.surveyType});

  @override
  State<OutlineCustomDropDownMenu> createState() =>
      _OutlineCustomDropDownMenuState();
}

class _OutlineCustomDropDownMenuState extends State<OutlineCustomDropDownMenu> {
  late dynamic selectedValue = widget.selectedValue??widget.options.first;

  late final List<TaskType> taskTypes;
  late final List<WTaskType> wTaskTypes;


  @override
  void initState() {
    if (widget.surveyType == SurveyType.MARKET_VISIT) {
      taskTypes = (widget.options as List<TaskType>);
    } else {
      wTaskTypes = (widget.options as List<WTaskType>);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isDense: true,
      value: selectedValue,
      isExpanded: widget.isExpanded,
      items: widget.options.map((option) {
        return DropdownMenuItem<dynamic>(
            value: option,
            child: Text(
              option.taskType??"",
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
        widget.onChanged(value!);
      },
    );
  }
}

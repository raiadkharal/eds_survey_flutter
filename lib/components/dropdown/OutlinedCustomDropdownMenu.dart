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
  final Function(dynamic) onChanged;

  const OutlineCustomDropDownMenu(
      {super.key,
      required this.options,
      this.isExpanded = true,
      this.underLined = true, required this.onChanged, required this.surveyType});

  @override
  State<OutlineCustomDropDownMenu> createState() =>
      _OutlineCustomDropDownMenuState();
}

class _OutlineCustomDropDownMenuState extends State<OutlineCustomDropDownMenu> {

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
      alignment:AlignmentDirectional.centerStart,
      hint: const Align(alignment: Alignment.centerLeft,child: Text("select task"),),
      isExpanded: widget.isExpanded,
      items: widget.options.map((option) {
        return DropdownMenuItem<dynamic>(
            value: option,
            alignment:AlignmentDirectional.centerStart,
            child: Text(
              option.taskType??"",
              overflow: TextOverflow.ellipsis,
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
        widget.onChanged(value!);
      },
    );
  }
}

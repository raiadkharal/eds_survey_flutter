import 'package:eds_survey/data/models/CheckBoxModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckListItem extends StatelessWidget {
  final int index;
  final bool value;
  final List<CheckBoxModel> skuList;
  final Function(bool, int) onChanged;

  const CheckListItem(
      {super.key,
      required this.index,
      required this.skuList,
      required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${index + 1}.SKUS-Availability CheckList-${index + 1}",
            style: GoogleFonts.roboto(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: skuList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Checkbox(
                    value: value,
                    onChanged: (value) => onChanged(value!, index),
                  ),
                  Text(
                    skuList[index].title,
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
    ;
  }
}

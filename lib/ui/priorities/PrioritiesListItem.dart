import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import '../../components/dropdowns/oulinedCustomDropdoenMenu.dart';

class PrioritiesListItem extends StatefulWidget {
  final List<String> tasks;
  final VoidCallback delete;

  const PrioritiesListItem(
      {super.key, required this.tasks, required this.delete});

  @override
  State<PrioritiesListItem> createState() => _PrioritiesListItemState();
}

class _PrioritiesListItemState extends State<PrioritiesListItem> {
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 5, child: OutlineCustomDropDownMenu(options: widget.tasks)),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: InkWell(
                onTap: () async {
                  //show date picker and accept data back as String
                  String selectedDate = await selectTaskDate(context);
                  _dateController.text = selectedDate;
                  Fluttertoast.showToast(
                      msg: "Selected Date is: $selectedDate");
                },
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                      enabled: false,
                      disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: "Select Date",
                      hintStyle:
                          GoogleFonts.roboto(color: Colors.grey, fontSize: 12),
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey))),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: IconButton(
                  onPressed:widget.delete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )))
        ],
      ),
    );
  }

  Future<String> selectTaskDate(BuildContext context) async {
    //show date picker dialog to user
    final DateTime? pickedDate = await showDatePicker(

        context: context, firstDate: DateTime(2000), lastDate: DateTime(2101));

    // Convert selectedDate to String using intl package
    String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate!);

    return formattedDate;
  }
}

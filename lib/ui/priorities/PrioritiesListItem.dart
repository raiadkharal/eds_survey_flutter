import 'package:eds_survey/components/dialog/sku_avalability/sku_availability_dialog.dart';
import 'package:eds_survey/data/db/entities/task_type.dart';
import 'package:eds_survey/data/db/entities/workwith/WTaskType.dart';
import 'package:eds_survey/ui/priorities/PrioritiesViewModel.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import '../../components/dropdown/OutlinedCustomDropdownMenu.dart';
import '../../data/db/entities/task.dart';

class PrioritiesList extends StatefulWidget {
  final List<dynamic>? taskTypes;
  final SurveyType surveyType;
  final List<Task> tasks;

  const PrioritiesList({
    super.key,
    required this.taskTypes,
    required this.tasks,
    required this.surveyType,
  });

  @override
  State<PrioritiesList> createState() => _PrioritiesListState();
}

class _PrioritiesListState extends State<PrioritiesList> {
  final TextEditingController dateController = TextEditingController();
  final PrioritiesViewModel controller = Get.find<PrioritiesViewModel>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: widget.tasks.length,
          itemBuilder: (context, index) {
            Task task = widget.tasks[index];
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              key: ObjectKey(task),
              children: [
                Expanded(
                    flex: 7,
                    child: OutlineCustomDropDownMenu(
                      options: widget.taskTypes ?? [],
                      onChanged: (taskType) {
                        if (taskType.taskTypeId != null) {
                          if ((taskType.taskTypeId == 3 ||
                              taskType.taskTypeId == 13)) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                                insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                                content: SkuAvailabilityDialog(
                                  onSave: (selectedMissingSkus) {
                                    task.remarks = taskType.taskType;
                                    task.taskId = taskType.taskTypeId ?? 0;
                                    task.missingSkus = selectedMissingSkus;
                                    controller.updateTask(widget.tasks[index]);
                                  }, task: task,
                                ),
                              ),
                            );
                          }
                          task.remarks = taskType.taskType;
                          task.taskId = taskType.taskTypeId ?? 0;
                          controller.updateTask(widget.tasks[index]);
                        }
                      },
                      surveyType: widget.surveyType,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: InkWell(
                        onTap: () async {
                          //show date picker and accept data back as String
                          String? selectedDate = await selectTaskDate(context);
                          setState(() {
                            task.taskDate = selectedDate;
                          });
                          controller.updateTask(widget.tasks[index]);
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                task.taskDate ?? "Select Date",
                                style: GoogleFonts.roboto(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey,
                            )
                          ],
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.tasks.removeAt(index);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        )))
              ],
            );
          },
        ));
  }

  Future<String?> selectTaskDate(BuildContext context) async {
    try {
      //show date picker dialog to user
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now().subtract(const Duration(days: 0)),
          lastDate: DateTime(2101));

      // Convert selectedDate to String using intl package
      if (pickedDate != null) {
        return DateFormat('MM-dd-yyyy').format(pickedDate);
      }
    } catch (e) {
      showToastMessage("Something went wrong. Please try again later");
    }
    return null;
  }
}

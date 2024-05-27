import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/button/CustomButton.dart';
import 'package:eds_survey/data/WorkWithSingletonModel.dart';
import 'package:eds_survey/data/db/entities/task_type.dart';
import 'package:eds_survey/ui/market_visit/feedback/SurveyFeedbackScreen.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletsScreen.dart';
import 'package:eds_survey/ui/priorities/PrioritiesListItem.dart';
import 'package:eds_survey/ui/priorities/PrioritiesViewModel.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../components/progress_dialog/PregressDialog.dart';
import '../../data/SurveySingletonModel.dart';
import '../../data/db/entities/task.dart';
import '../../utils/Colors.dart';

class PrioritiesScreen extends StatefulWidget {
  const PrioritiesScreen({super.key});

  @override
  State<PrioritiesScreen> createState() => _PrioritiesScreenState();
}

class _PrioritiesScreenState extends State<PrioritiesScreen> {
  final PrioritiesViewModel controller =
      Get.put(PrioritiesViewModel(Get.find()));

  late final SurveyType surveyType;
  late final int outletId;

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];
    init();
    setObservers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: NavDrawer(
        baseContext: context,
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //     )),
          title: Text(
            "EDS Survey",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "POST SURVEY TASK",
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                        onPressed: () {
                          controller
                              .addNewTask(Task(taskId: 1, taskName: null));
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.black,
                          size: 30,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 5,
                        child: Text(
                          "Task",
                          style: GoogleFonts.roboto(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    Expanded(
                        flex: 2,
                        child: Text(
                          "Target Date",
                          style: GoogleFonts.roboto(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                    const Expanded(child: SizedBox())
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Obx(
                  () => PrioritiesList(
                    taskTypes: controller.tasksTypes.value,
                    tasks: controller.tasks.value,
                    surveyType: surveyType,
                  ),
                ),
              )),
              CustomButton(
                onTap: () => onNextClick(context),
                text: surveyType == SurveyType.SURVEY_WITH ? "Finish" : "Next",
                enabled: true,
                fontSize: 22,
                horizontalPadding: 10,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Obx(
            () => controller.isLoading().value
                ? const SimpleProgressDialog()
                : const SizedBox(),
          )
        ],
      ),
    );
  }

  void init() {
    if (surveyType == SurveyType.MARKET_VISIT) {
      controller.loadMVTaskTypes(outletId);
    } else {
      controller.loadWWTaskTypes(outletId);
    }
  }

  Future<void> onNextClick(BuildContext context) async {
    List<Task> tasks = controller.tasks.value;

    if (tasks.isNotEmpty) {
      for (Task task in tasks) {
        if (task.taskId == 3 || task.taskId == 13) {
          if (task.taskDate == null || task.remarks == null) {
            showToastMessage("Please enter task data");
            return;
          }
          if (task.missingSkus == null || task.missingSkus!.isEmpty) {
            showToastMessage("Please select missing Skus");
            return;
          }
        } else {
          if (task.taskDate == null || task.remarks == null) {
            showToastMessage("Please enter task data");
            return;
          }
        }
      }
    } else {
      showToastMessage("Please add tasks");
      return;
    }

    if (surveyType == SurveyType.MARKET_VISIT) {
      SurveySingletonModel.getInstance().setTasks(tasks);

      final result = await Get.toNamed(Routes.surveyFeedback,
          arguments: [outletId, surveyType]);

      if (result == "ok") {
        Get.back(result: result);
      }
    } else {
      //low memory dialog
      if (WorkWithSingletonModel.getInstance().getOutletId() == null ||
          WorkWithSingletonModel.getInstance().getOutletId() == 0) {
        //Low memory dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Low Memory Resources"),
            content: const Text(
                "Your device memory is running low. Please click ok to refresh"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    return;
                  },
                  child: const Text("Ok"))
            ],
          ),
        );
        return;
      }

      //finish survey verification
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Finish Survey!"),
          content: const Text(
              "Are you sure you want to complete the survey for this outlet?"),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                return;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No",
                  style: GoogleFonts.roboto(
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                if (checkTasks(tasks)) {
                  try {
                    Navigator.of(context).pop();
                    controller.priorityRemarksDataSet();
                  } catch (e) {
                    showToastMessage(
                        "Something went Wrong.Please try again later");
                  }
                } else {
                  showToastMessage("Please enter correct data");
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Yes",
                  style: GoogleFonts.roboto(
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  bool checkTasks(List<Task> tasks) {
    for (Task task in tasks) {
      if (task.taskDate == null || task.remarks == null) {
        return false;
      }
    }
    return true;
  }

  void setObservers() {
    debounce(controller.getMessage(), (event) {
      showToastMessage(event.peekContent());
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getPostWorkWithSaved(), (aBoolean) {
      if (aBoolean) {
        // Get.back(result: "ok");
        Get.until((route) => Get.currentRoute == Routes.outletList);
        WorkWithSingletonModel.getInstance().reset();
      }
    }, time: const Duration(milliseconds: 100));
  }
}

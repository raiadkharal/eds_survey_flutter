import 'package:eds_survey/components/buttons/custom_button.dart';
import 'package:eds_survey/ui/priorities/PrioritiesListItem.dart';
import 'package:eds_survey/ui/priorities/PrioritiesViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/navigation_drawer/nav_drawer.dart';
import '../../utils/Colors.dart';

class PrioritiesScreen extends StatefulWidget {
  const PrioritiesScreen({super.key});

  @override
  State<PrioritiesScreen> createState() => _PrioritiesScreenState();
}

class _PrioritiesScreenState extends State<PrioritiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PrioritiesViewModel>(
      builder: (context, prioritiesViewModel, child) {
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
          body: Column(
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
                          prioritiesViewModel.addNewTask("task");
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                    const Expanded(child: SizedBox())
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ListView.builder(
                                    itemCount: prioritiesViewModel.tasks.length,
                                    itemBuilder: (context, index) {
                    List<String> tasks = prioritiesViewModel.tasks;
                    return PrioritiesListItem(
                      tasks: tasks,
                      delete: () {
                        prioritiesViewModel.deleteTaskAtPosition(index);
                      },
                    );
                                    },
                                  ),
                  )),
              CustomButton(
                onTap: () {},
                text: "Next",
                enabled: true,
                fontSize: 22,
                horizontalPadding: 10,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}

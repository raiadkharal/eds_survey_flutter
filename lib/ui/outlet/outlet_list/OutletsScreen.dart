import 'package:eds_survey/data/db/entities/outlet.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletListItem.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletsViewModel.dart';
import 'package:eds_survey/ui/outlet/summary/OutletSummaryScreen.dart';
import 'package:eds_survey/ui/outlet/summary/OutletSummaryViewModel.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Route.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../data/db/entities/workwith/WOutlet.dart';
import '../../../utils/Colors.dart';

class OutletListScreen extends StatefulWidget {
  const OutletListScreen({
    super.key,
  });

  @override
  State<OutletListScreen> createState() => _OutletListScreenState();
}

class _OutletListScreenState extends State<OutletListScreen> {
  final OutletsViewModel controller =
      Get.put<OutletsViewModel>(OutletsViewModel(Get.find()));

  @override
  void initState() {
    List<dynamic>? args = Get.arguments;
    if (args != null) {
      controller.setSelectedRouteId(args[0]);
      controller.setSelectedDistributionId(args[1]);
      controller.setSurveyType(args[2]);
    }

    controller.init();
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
        title: Text(
          "OUTLET LIST",
          style: GoogleFonts.roboto(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(controller));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "OUTLET LIST",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: controller.loadOutlets(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () => ListView.separated(
                    itemCount: controller.outlets.value.length,
                    itemBuilder: (context, index) {
                      return OutletListItem(
                        onTap: (outletId) async {
                          final result = await Get.toNamed(Routes.outletSummary,
                              arguments: [
                                outletId,
                                controller.getSurveyType()
                              ]);
                          if (result == "ok") {
                            setState(() {});
                          }
                        },
                        outletItem: controller.outlets.value[index],
                        surveyType: controller.getSurveyType() ??
                            SurveyType.MARKET_VISIT,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.black54,
                        height: 0.5,
                        width: double.infinity,
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final OutletsViewModel controller;

  CustomSearchDelegate(this.controller);


  @override
  String? get searchFieldLabel => "Enter Outlet Name or Code";

  @override
  TextStyle? get searchFieldStyle => GoogleFonts.roboto(fontSize: 16);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<dynamic> filteredItems = [];

    if (controller.getSurveyType() == SurveyType.MARKET_VISIT) {
      filteredItems = controller.outlets.value
          .where((outlet) =>
              (outlet as Outlet)
                  .outletName
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              outlet.outletCode.toString().contains(query))
          .toList() as List<Outlet>;
    } else if (controller.getSurveyType() == SurveyType.SURVEY_WITH) {
      filteredItems = controller.outlets.value
          .where((outlet) =>
              (outlet as WOutlet)
                  .outletName
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              outlet.outletCode.toString().contains(query))
          .toList() as List<WOutlet>;
    }
    return ListView.separated(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return OutletListItem(
          onTap: (outletId) async {

            //Clear focus
            FocusScope.of(context).requestFocus(FocusNode());

            //close search bar
            close(context, null);

            Get.toNamed(Routes.outletSummary,
                arguments: [outletId, controller.getSurveyType()]);
          },
          outletItem: filteredItems[index],
          surveyType: controller.getSurveyType() ?? SurveyType.MARKET_VISIT,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.black54,
          height: 0.5,
          width: double.infinity,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<dynamic> filteredItems = [];

    if (controller.getSurveyType() == SurveyType.MARKET_VISIT) {
      filteredItems = controller.outlets.value
          .where((outlet) =>
              (outlet as Outlet)
                  .outletName
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              outlet.outletCode.toString().contains(query))
          .toList() as List<Outlet>;
    } else if (controller.getSurveyType() == SurveyType.SURVEY_WITH) {
      filteredItems = controller.outlets.value
          .where((outlet) =>
              (outlet as WOutlet)
                  .outletName
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              outlet.outletCode.toString().contains(query))
          .toList() as List<WOutlet>;
    }
    return ListView.separated(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        return OutletListItem(
          onTap: (outletId) async {

            //Clear focus
            FocusScope.of(context).requestFocus(FocusNode());

            //close search bar
            close(context, null);

            //navigate to outlet summary screen
            Get.toNamed(Routes.outletSummary,
                arguments: [outletId, controller.getSurveyType()]);
          },
          outletItem: filteredItems[index],
          surveyType: controller.getSurveyType() ?? SurveyType.MARKET_VISIT,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.black54,
          height: 0.5,
          width: double.infinity,
        );
      },
    );
  }
}

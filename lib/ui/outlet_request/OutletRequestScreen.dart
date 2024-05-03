import 'package:eds_survey/Route.dart';
import 'package:eds_survey/ui/outlet_request/draft/DraftScreen.dart';
import 'package:eds_survey/ui/outlet_request/reverted/RevertedScreen.dart';
import 'package:eds_survey/ui/outlet_request/synced/SyncedScreen.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OutletRequestScreen extends StatefulWidget {
  const OutletRequestScreen({super.key});

  @override
  State<OutletRequestScreen> createState() => _OutletRequestScreenState();
}

class _OutletRequestScreenState extends State<OutletRequestScreen> {
  final List<String> tabTitles = ["DRAFT", "SYNCED", "REVERTED"];

  final List<Widget> pages = [
    const DraftScreen(),
    const SyncedScreen(),
    const RevertedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {
                  showToastMessage("Sync clicked");
                },
                icon: const Icon(Icons.sync)),

            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.newOutletRequest);
                },
                icon: const Icon(Icons.add,color: Colors.black,)),

          ],
          bottom: TabBar(
            labelColor: primaryColor,
            indicatorColor: primaryColor,
              indicatorSize:TabBarIndicatorSize.tab,
              tabs: tabTitles
                  .map((title) => Tab(
                        text: title,
                      ))
                  .toList()),
          title: Text(
            "OUTLET REQUEST",
            style: GoogleFonts.roboto(color: Colors.black),
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    );
  }
}

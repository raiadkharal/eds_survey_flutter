import 'package:eds_survey/ui/new_outlet_request/form_one/FormOne.dart';
import 'package:eds_survey/ui/new_outlet_request/form_two/FormTwo.dart';
import 'package:eds_survey/ui/outlet_request/draft/DraftScreen.dart';
import 'package:eds_survey/ui/outlet_request/reverted/RevertedScreen.dart';
import 'package:eds_survey/ui/outlet_request/synced/SyncedScreen.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewOutletRequestScreen extends StatefulWidget {
  const NewOutletRequestScreen({super.key});

  @override
  State<NewOutletRequestScreen> createState() => _NewOutletRequestScreenState();
}

class _NewOutletRequestScreenState extends State<NewOutletRequestScreen> {
  final List<Widget> pages = [
    FormOne(),
    FormTwo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                showToastMessage("Sync clicked");
              },
              icon: const Icon(Icons.sync)),
          TextButton(
              onPressed: () {
                showToastMessage("ok clicked");
              },
              child: Text(
                "OK",
                style: GoogleFonts.roboto(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ))
        ],
        title: Text(
          "OUTLET REQUEST",
          style: GoogleFonts.roboto(color: Colors.black),
        ),
      ),
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }
}

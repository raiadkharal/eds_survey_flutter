import 'package:eds_survey/components/buttons/custom_button.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletListScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/dropdowns/simple_dropdown.dart';

class WorkWithMainScreen extends StatelessWidget {
  const WorkWithMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "MAIN SCREEN",
          style: GoogleFonts.roboto(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Distribution",
              style: GoogleFonts.roboto(),
            ),
            const CustomSimpleDropdownButton(
                options: ['Item1', 'Item2', 'Item3']),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Routes",
              style: GoogleFonts.roboto(),
            ),
            const CustomSimpleDropdownButton(
                options: ['Item1', 'Item2', 'Item3']),
            const SizedBox(
              height: 16,
            ),
            CustomButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OutletListScreen(),
                      ));
                },
                text: "Load Outlets")
          ],
        ),
      ),
    );
  }
}

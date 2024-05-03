import 'package:eds_survey/ui/outlet_request/OutletRequestItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Colors.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({super.key});

  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (context, index) => const OutletRequestItem(),
          separatorBuilder: (context, index) => Container(
                color: Colors.grey,
                height: 1,
              ),
          itemCount: 5),
    );
  }
}

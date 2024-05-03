import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Colors.dart';
import '../OutletRequestItem.dart';

class RevertedScreen extends StatefulWidget {
  const RevertedScreen({super.key});

  @override
  State<RevertedScreen> createState() => _RevertedScreenState();
}

class _RevertedScreenState extends State<RevertedScreen> {
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


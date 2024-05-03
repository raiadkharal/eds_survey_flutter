import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Colors.dart';
import '../OutletRequestItem.dart';


class SyncedScreen extends StatefulWidget {
  const SyncedScreen({super.key});

  @override
  State<SyncedScreen> createState() => _SyncedScreenState();
}

class _SyncedScreenState extends State<SyncedScreen> {
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


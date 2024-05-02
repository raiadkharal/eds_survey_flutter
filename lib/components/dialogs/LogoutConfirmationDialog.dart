import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const LogoutConfirmationDialog(
      {super.key, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Logout!",
        style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Are you sure you want to logout?",
            style: GoogleFonts.roboto(fontSize: 14),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: onCancel,
                  child: Text(
                    "No",
                    style: GoogleFonts.roboto(color: Colors.black),
                  )),
              TextButton(
                  onPressed: onConfirm,
                  child: Text(
                    "Yes",
                    style: GoogleFonts.roboto(color: Colors.black),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

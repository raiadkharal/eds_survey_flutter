import 'package:eds_survey/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class OutletListItem extends StatelessWidget {
  final VoidCallback onTap;
  const OutletListItem({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Outlet Name",
                      style: GoogleFonts.roboto(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Outlet Code: " + "21154512354",
                      style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Last Visit: " + "Last Visit 16 days ago",
                      style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "NO SALE",
                      style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset("assets/images/ic_location.png")),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset("assets/images/ic_done.png")),
              const SizedBox(
                width: 8,
              ),
              Container(
                color: Colors.red.shade800,
                height: 80,
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

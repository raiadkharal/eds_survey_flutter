import 'package:eds_survey/data/db/entities/outlet_request/RequestForm.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class OutletRequestItem extends StatelessWidget {
  final RequestForm requestForm;
  const OutletRequestItem({super.key, required this.requestForm});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(requestForm.outletName??"",style: GoogleFonts.roboto(color: Colors.black,fontSize:18,fontWeight:FontWeight.w500)),
          Text(requestForm.outletAddress??"",style: GoogleFonts.roboto(color: Colors.grey,fontSize:14)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    color: primaryColor,
                    child: Text(
                      "10 DAYS AGO",
                      style: GoogleFonts.roboto(color: Colors.white),textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 6,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    color: primaryColor,
                    child: Text(
                      "DRAFT",
                      style: GoogleFonts.roboto(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

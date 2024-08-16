import 'package:eds_survey/data/db/entities/outlet.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/db/entities/workwith/WOutlet.dart';

class OutletListItem extends StatelessWidget {
  final Function(int) onTap;
  final Object outletItem;
  final SurveyType surveyType;

  const OutletListItem(
      {super.key,
      required this.onTap,
      required this.outletItem,
      required this.surveyType});

  @override
  Widget build(BuildContext context) {
    late final Outlet outlet;
    late final WOutlet wOutlet;
    bool isAlreadyVisited = false;
    if (surveyType == SurveyType.MARKET_VISIT) {
      outlet = (outletItem as Outlet);
      isAlreadyVisited = outlet.alreadyVisit ?? false;
    } else {
      wOutlet = (outletItem as WOutlet);
      isAlreadyVisited = wOutlet.alreadyVisit ?? false;
    }
    return InkWell(
      onTap: () {
        if(!isAlreadyVisited){
          onTap(surveyType == SurveyType.MARKET_VISIT
              ? outlet.outletId ?? 0
              : wOutlet.outletId);
        }
      },
      child: Container(
        color: isAlreadyVisited ? Colors.grey.shade500 : Colors.grey.shade200,
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
                      surveyType == SurveyType.MARKET_VISIT
                          ? "${outlet.outletName} - ${outlet.location}"
                          :"${wOutlet.outletName} - ${wOutlet.location}",
                      style: GoogleFonts.roboto(
                          color: primaryColor
                          ,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Outlet Code: ${surveyType == SurveyType.MARKET_VISIT ? outlet.outletCode ?? "OutletCOde" : wOutlet.outletCode ?? "OutletCOde"}",
                      style: GoogleFonts.roboto(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    if (surveyType == SurveyType.MARKET_VISIT
                        ? outlet.lastVisit != null
                        : wOutlet.lastVisit != null)
                      Text(
                        "Last Visit: ${surveyType == SurveyType.MARKET_VISIT ? outlet.lastVisit : wOutlet.lastVisit}",
                        style: GoogleFonts.roboto(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    const SizedBox(
                      height: 6,
                    ),
                    if (surveyType == SurveyType.MARKET_VISIT
                        ? outlet.isZeroSaleOutlet ?? false
                        : wOutlet.isZeroSaleOutlet ?? false)
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
              if (surveyType == SurveyType.MARKET_VISIT
                  ? outlet.isPJP ?? false
                  : wOutlet.isPJP ?? false)
                SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset("assets/images/ic_location.png")),
              const SizedBox(
                width: 8,
              ),
              if ((surveyType == SurveyType.MARKET_VISIT
                  ? outlet.synced ?? false
                  : wOutlet.surveyTaken ?? false)||isAlreadyVisited)
                SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset("assets/images/ic_done.png")),
              const SizedBox(
                width: 8,
              ),
              if (surveyType == SurveyType.MARKET_VISIT
                  ? outlet.isZeroSaleOutlet ?? false
                  : wOutlet.isZeroSaleOutlet ?? false)
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

import 'package:eds_survey/data/db/entities/outlet.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletListItem.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletsViewModel.dart';
import 'package:eds_survey/ui/outlet/summary/OutletSummaryScreen.dart';
import 'package:eds_survey/ui/outlet/summary/OutletSummaryViewModel.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Route.dart';
import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../data/db/entities/workwith/WOutlet.dart';
import '../../../utils/Colors.dart';

class OutletListScreen extends StatefulWidget {
  const OutletListScreen({
    super.key,
  });

  @override
  State<OutletListScreen> createState() => _OutletListScreenState();
}

class _OutletListScreenState extends State<OutletListScreen> {
  final OutletsViewModel controller = Get.find<OutletsViewModel>();

  @override
  void initState() {
   List<dynamic>? args=Get.arguments;
   if(args!=null) {
     controller.setSelectedRouteId(args[0]);
     controller.setSelectedDistributionId(args[1]);
     controller.setSurveyType(args[2]);
   }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: NavDrawer(
        baseContext: context,
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //     )),
          title: Text(
            "EDS Survey",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "OUTLET LIST",
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: FutureBuilder<List<dynamic>>(
            future: controller.loadOutlets(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var outlets = [];
                if (controller.getSurveyType() == SurveyType.MARKET_VISIT) {
                  outlets = snapshot.requireData.isNotEmpty
                      ? snapshot.requireData as List<Outlet>
                      : [];
                } else {
                  outlets = snapshot.requireData.isNotEmpty
                      ? snapshot.requireData as List<WOutlet>
                      : [];
                }
                return ListView.separated(
                  itemCount: outlets.length,
                  itemBuilder: (context, index) {
                    return OutletListItem(
                      onTap: (outletId) {
                        Get.toNamed(Routes.outletSummary,
                            arguments: [outletId,controller.getSurveyType()]);
                      },
                      outletItem: outlets[index],
                      surveyType: controller.getSurveyType()??SurveyType.MARKET_VISIT,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey,
                      height: 0.5,
                      width: double.infinity,
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
    );
  }
}

import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/outlet_request/reverted/RevertedViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Colors.dart';
import '../../../utils/Constants.dart';
import '../OutletRequestItem.dart';

class RevertedScreen extends StatefulWidget {
  const RevertedScreen({super.key});

  @override
  State<RevertedScreen> createState() => _RevertedScreenState();
}

class _RevertedScreenState extends State<RevertedScreen> {
  final RevertedViewModel controller =
      Get.put<RevertedViewModel>(RevertedViewModel(Get.find<Repository>()));


  @override
  void initState() {
    super.initState();
    controller.getRevertedForms(Constants.NEW_OUTLET_REQUEST_TYPE_ID,Constants.OUTLETS_REVERTED_WORKFLOW);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.separated(
            itemBuilder: (context, index) => OutletRequestItem(requestForm: controller.revertedForms[index],),
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey,
                  height: 1,
                ),
            itemCount: controller.revertedForms.length),
      ),
    );
  }
}

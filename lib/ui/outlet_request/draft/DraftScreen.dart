import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/outlet_request/OutletRequestItem.dart';
import 'package:eds_survey/ui/outlet_request/draft/DraftViewModel.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Colors.dart';

class DraftScreen extends StatefulWidget {
  const DraftScreen({super.key});

  @override
  State<DraftScreen> createState() => _DraftScreenState();
}

class _DraftScreenState extends State<DraftScreen> {

  final controller = Get.put<DraftViewModel>(DraftViewModel(Get.find<Repository>()));

  @override
  void initState() {
    setObservers();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => ListView.separated(
          itemBuilder: (context, index) =>  OutletRequestItem(requestForm: controller.draftForms[index],),
          separatorBuilder: (context, index) => Container(
            color: Colors.grey,
            height: 1,
          ),
          itemCount: controller.draftForms.length),),
    );
  }

  void setObservers() {
    debounce(controller.isOutletRequestSaved(), (aBoolean) {
      if(aBoolean){
        controller.getDraftForm(Constants.NEW_OUTLET_REQUEST_TYPE_ID);
      }
    });
  }
}

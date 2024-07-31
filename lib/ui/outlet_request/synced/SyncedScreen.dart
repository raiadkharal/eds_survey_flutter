import 'package:eds_survey/ui/outlet_request/synced/SyncedViewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/Colors.dart';
import '../../../utils/Constants.dart';
import '../OutletRequestItem.dart';

class SyncedScreen extends StatefulWidget {
  const SyncedScreen({super.key});

  @override
  State<SyncedScreen> createState() => _SyncedScreenState();
}

class _SyncedScreenState extends State<SyncedScreen> {
  final SyncedViewModel controller = Get.put(SyncedViewModel(Get.find()));

  @override
  void initState() {
    super.initState();
    controller.getRevertedForms(Constants.OUTLETS_REVERTED_WORKFLOW,Constants.NEW_OUTLET_REQUEST_TYPE_ID);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.separated(
            itemBuilder: (context, index) => OutletRequestItem(
                  requestForm: controller.syncedForms[index],
                ),
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey,
                  height: 1,
                ),
            itemCount: controller.syncedForms.length),
      ),
    );
  }
}

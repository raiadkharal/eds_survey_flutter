import 'package:eds_survey/components/button/CustomButton.dart';
import 'package:eds_survey/ui/upload/UploadViewModel.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/NetworkManager.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/progress_dialog/PregressDialog.dart';
import '../../data/models/UploadProgressModel.dart';
import '../../utils/Colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final UploadViewModel controller =
      Get.put<UploadViewModel>(UploadViewModel(Get.find()));

  @override
  void initState() {
    setObservers();
    loadMarketVisits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: primaryColor,
            title: Text(
              "Upload",
              style: GoogleFonts.roboto(color: Colors.white),
            )),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.totalSurveys.value != 0
                                  ? "Survey List: ${controller.totalSurveys.value}"
                                  : "Survey List Empty",
                              style: GoogleFonts.roboto(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: 40,
                          width: 150,
                          child: CustomButton(
                              onTap: () => onUploadClick(), text: "UPLOAD"))
                    ],
                  ),
                  Text("( ${controller.getCurrentDate()} )",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: primaryColor,
                      height: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 20,
                                width: 20,
                                child:
                                    Image.asset("assets/images/ic_done.png")),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                "Uploaded: ${controller.totalUploaded.value}/${controller.totalSurveys.value}",
                                style: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                                height: 20,
                                width: 20,
                                child: Image(
                                  image:
                                      AssetImage("assets/images/ic_done.png"),
                                  color: Colors.red,
                                  colorBlendMode: BlendMode.color,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Obx(
                              () => Text(
                                "Pending: ${controller.totalPending.value}/${controller.totalSurveys.value}",
                                style: GoogleFonts.roboto(
                                    color: Colors.grey.shade600, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        itemCount: controller.dataList.value.length,
                        itemBuilder: (context, index) {
                          List<UploadProgressModel> dataList =
                              controller.dataList.value;
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    dataList[index].description ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                        color: Colors.grey.shade600,
                                        fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Image(
                                      image: const AssetImage(
                                          "assets/images/ic_done.png"),
                                      color: dataList[index].getSynced()
                                          ? Colors.green
                                          : Colors.red,
                                      colorBlendMode: BlendMode.color,
                                    ))
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.grey,
                            height: 1,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(
              () => controller.isLoading().value
                  ? const SimpleProgressDialog()
                  : const SizedBox(),
            )
          ],
        ));
  }

  void onUploadClick() {
    NetworkManager.getInstance().isConnectedToInternet().then((aBoolean) {
      List<UploadProgressModel> dataList = [];
      dataList.addAll(controller.getUploadProgressMarketItems());
      dataList.addAll(controller.getUploadProgressPreItems());
      dataList.addAll(controller.getUploadProgressPostItems());
      if (aBoolean) {
        // check upload list size
        if (dataList.isNotEmpty) {
          try {
            checkAllDataUploadedOrNot();
          } catch (e) {
            showToastMessage(e.toString());
          }
        } else {
          showToastMessage("No Data Available");
        }
      } else {
        showToastMessage("No Connection Available");
      }
    });
  }

  void setObservers() {
    debounce(controller.itemDataAvailable, (available) {
      if (available) {
        List<UploadProgressModel> dataList = [];
        dataList.addAll(controller.getUploadProgressMarketItems());
        dataList.addAll(controller.getUploadProgressPreItems());
        dataList.addAll(controller.getUploadProgressPostItems());

        //update data list
        controller.updateData(dataList);
        //set total surveys
        controller.setTotalSurveys(dataList.length);
        //total pending and uploaded surveys
        checkTotalUploadedOrPending();
      }
    });

    // debounce(controller.getMessage(), (event) {
    //   showToastMessage(event.peekContent());
    // }, time: const Duration(milliseconds: 200));

    // debounce(controller.getProgressMsg(), (event) {
    //   if (event.peekContent() != "") {
    //     showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: const Text("Uploading Data.."),
    //         content: Text(event.peekContent()),
    //       ),
    //     );
    //   } else {
    //     // Navigator.pop(context);
    //   }
    // });

    debounce(controller.getUploadCompleted(), (aBoolean) {
      if (aBoolean) {
        showToastMessage("Data Uploaded Success");
        loadMarketVisits();
      }
    }, time: const Duration(milliseconds: 200));
  }

  void loadMarketVisits() {
    controller.loadMarketVisits();
  }

  void checkTotalUploadedOrPending() {
    List<UploadProgressModel> dataList = [];
    dataList.addAll(controller.getUploadProgressMarketItems());
    dataList.addAll(controller.getUploadProgressPreItems());
    dataList.addAll(controller.getUploadProgressPostItems());

    //total uploaded data
    int totalUploadedData = 0;
    // total pending data
    int totalPendingData = 0;

    for (int i = 0; i < dataList.length; i++) {
      if (dataList[i].getSynced()) {
        totalUploadedData++;
      }
      if (!dataList[i].getSynced()) {
        totalPendingData++;
      }
    }

    controller.setTotalUploaded(totalUploadedData);
    controller.setTotalPending(totalPendingData);
  }

  void checkAllDataUploadedOrNot() {
    bool isAllDataUploaded = true;
    List<UploadProgressModel> dataList = [];
    dataList.addAll(controller.getUploadProgressMarketItems());
    dataList.addAll(controller.getUploadProgressPreItems());
    dataList.addAll(controller.getUploadProgressPostItems());

    for (UploadProgressModel uploaded in dataList) {
      if (!uploaded.getSynced()) {
        isAllDataUploaded = false;
      }
    }

    if (isAllDataUploaded == true) {
      showToastMessage("Already All Data Uploaded!");
    } else {
      // uploadInProgress = true;
      // btnUpload.setClickable(false);
      controller.uploadAllData();
    }
  }
}

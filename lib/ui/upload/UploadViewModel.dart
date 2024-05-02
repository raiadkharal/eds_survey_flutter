import 'package:eds_survey/data/db/entities/workwith/WorkWithPost.dart';
import 'package:eds_survey/data/db/entities/workwith/WorkWithPre.dart';
import 'package:eds_survey/data/models/UploadProgressModel.dart';
import 'package:eds_survey/ui/home/HomeRepository.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/db/entities/market_visit.dart';
import '../../utils/Event.dart';
import '../../utils/Util.dart';

class UploadViewModel extends GetxController {
  final HomeRepository _repository;
  List<UploadProgressModel> uploadProgressItems = [];
  List<UploadProgressModel> uploadProgressMarketItems = [];
  List<UploadProgressModel> uploadProgressPreItems = [];
  List<UploadProgressModel> uploadProgressPostItems = [];

  late Rx<List<UploadProgressModel>> dataList;

  late RxBool itemDataAvailable;
  late RxBool uploadCompleted;
  late RxInt totalSurveys;
  late RxInt totalUploaded;
  late RxInt totalPending;

  UploadViewModel(this._repository) {
    itemDataAvailable = false.obs;
    uploadCompleted = false.obs;
    totalSurveys = 0.obs;
    totalUploaded = 0.obs;
    totalPending = 0.obs;
    dataList = RxList<UploadProgressModel>([]).obs;
  }

  String getCurrentDate() {
    return Util.formatDate(
        Util.DATE_FORMAT_3, DateTime.now().millisecondsSinceEpoch);
  }

  List<UploadProgressModel> getUploadProgressMarketItems() =>
      uploadProgressMarketItems;

  List<UploadProgressModel> getUploadProgressPreItems() =>
      uploadProgressPreItems;

  List<UploadProgressModel> getUploadProgressPostItems() =>
      uploadProgressPostItems;

  void loadMarketVisits() {
    getAllSurveyItems();
  }

  void getAllSurveyItems() {
    // setLoading(true);
    uploadProgressItems = [];
    uploadProgressMarketItems = [];

    _repository.getAllSurveyItems().then((items) {
      uploadProgressMarketItems = [];

      for (MarketVisit item in items) {
        String uploadType = "Market";
        String description = "Market Visit of ${item.outletId}";
        uploadProgressMarketItems.add(UploadProgressModel.marketVisit(
            uploadType: uploadType,
            description: description,
            marketVisit: item));
      }

      getAllPreWorkItems();

      debugPrint("UploadMV size: ${items.length}");
    }).onError((error, stackTrace) {
      setLoading(false);
      showToastMessage(Constants.GENERIC_ERROR2);
    });
  }

  void getAllPreWorkItems() {
    uploadProgressPreItems = [];
    _repository.getAllPreWork().then((items) {
      uploadProgressPreItems = [];

      for (WorkWithPre item in items) {
        String uploadType = "PreWork";
        String description = "Pre Work of  ${item.outletId}";
        uploadProgressPreItems.add(UploadProgressModel.workWithPre(
            uploadType: uploadType,
            description: description,
            workWithPre: item));
      }

      getAllPostWorkItems();

      debugPrint("UploadVM: Work W size: ${items.length}");
    }).onError((error, stackTrace) {
      setLoading(false);
      showToastMessage(Constants.GENERIC_ERROR2);
    });
  }

  void getAllPostWorkItems() {
    uploadProgressPostItems = [];
    _repository.getAllPostWork().then((items) {
      uploadProgressPostItems = [];

      for (WorkWithPost item in items) {
        String uploadType = "PostWork";
        String description = "Post Work of  ${item.outletId}";
        uploadProgressPostItems.add(UploadProgressModel.workWithPost(
            uploadType: uploadType,
            description: description,
            workWithPost: item));
      }

      debugPrint("UploadVM:  Work W size: ${items.length}");

      setLoading(false);
      //notify UI that data is available
      itemDataAvailable(true);
      itemDataAvailable.refresh();
    }).onError((error, stackTrace) {
      setLoading(false);
      showToastMessage(Constants.GENERIC_ERROR2);
    });
  }

  void setTotalSurveys(int total) {
    totalSurveys.value = total;
    totalSurveys.refresh();
  }

  void setTotalUploaded(int uploadedCount) {
    totalUploaded.value = uploadedCount;
    totalUploaded.refresh();
  }

  void setTotalPending(int pendingCount) {
    totalPending(pendingCount);
    totalPending.refresh();
  }

  void updateData(List<UploadProgressModel> data) {
    dataList.value.clear();
    dataList.value.addAll(data);
    dataList.refresh();
  }

  void setLoading(bool value) {
   _repository.setLoading(value);
  }

  Rx<Event<String>> getMessage() => _repository.getMessage();

  Rx<Event<String>> getProgressMsg() => _repository.getProgressMsg();

  RxBool getUploadCompleted() => _repository.getUploadCompleted();
  RxBool isLoading() => _repository.isLoading();


  void setUploadCompleted(bool value){
    uploadCompleted.value=value;
    uploadCompleted.refresh();
  }
  void uploadAllData() =>
    _repository.uploadAllMarketVisitSurvey();
}

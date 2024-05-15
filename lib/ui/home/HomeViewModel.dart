import 'dart:async';

import 'package:eds_survey/data/db/entities/outlet_request/OutletTable.dart';
import 'package:eds_survey/data/db/entities/outlet_request/RequestForm.dart';
import 'package:eds_survey/data/models/DocumentTable.dart';
import 'package:eds_survey/data/models/RoutesModel.dart';
import 'package:eds_survey/data/models/WorkStatus.dart';
import 'package:eds_survey/ui/home/HomeRepository.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Event.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

import '../../utils/Util.dart';

class HomeViewModel extends GetxController {
  final HomeRepository _homeRepository;
  final Repository _repository;
  final PreferenceUtil _preferenceUtil;
  Rx<bool> endDay = Rx<bool>(false);
  RxString lastSyncDate = "".obs;

  HomeViewModel(this._homeRepository, this._preferenceUtil, this._repository);

  void checkDayEnd() {
    int lastSyncDate = _preferenceUtil.getWorkSyncData().syncDate;
    if (lastSyncDate != 0) {
      if (!Util.isDateToday(lastSyncDate)) {
        setStartDay(false);
      } else {
        setStartDay(true);
      }
    } else {
      setStartDay(false);
    }
  }

  void dayEnd() {
    _homeRepository.dayEndResults().then((marketVisitList) {
      if (marketVisitList.isNotEmpty) {
        showToastMessage("Please upload your latest data");
      } else {
        endDay(true);
        endDay.refresh();
      }
    });
  }

  void start() => _homeRepository.getToken();

  void setStartDay(bool value) => _homeRepository.setStartDay(value);

  void download() => _homeRepository.fetchData(true);

  void setSyncDate(String date) => lastSyncDate.value = date;

  RxBool isLoading() => _homeRepository.isLoading();

  RxBool startDay() => _homeRepository.startDay();

  Rx<Event<String>> getProgressMsg() => _homeRepository.getProgressMsg();

  Rx<Event<String>> getMessage() => _homeRepository.getMessage();

  Rx<RoutesModel> getRoutesLiveData()=>_homeRepository.getRoutesLiveData();

  bool isDayStarted() => _homeRepository.isDayStarted();

  WorkStatus getWorkSyncData() => _preferenceUtil.getWorkSyncData();

  void updateDayEndStatus() => _homeRepository.updateWorkStatus(false);

  void saveWorkSyncData(WorkStatus status) =>
      _preferenceUtil.saveWorkSyncData(status);

  void deleteTables(bool getRouteTables) {
    _homeRepository.deleteTables(getRouteTables);
  }

  void addDocuments(List<DocumentTable>? documents) {
    _homeRepository.addDocuments(documents);
  }

  void addOutlets(List<OutletTable>? outlets) {
    _homeRepository.addOutlets(outlets);
  }
}

import 'dart:async';
import 'dart:ffi';
import 'package:eds_survey/data/WorkWithSingletonModel.dart';
import 'package:eds_survey/data/db/entities/outlet.dart';
import 'package:eds_survey/data/db/entities/workwith/WOutlet.dart';
import 'package:eds_survey/data/models/Configuration.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/Event.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../utils/Util.dart';

class OutletSummaryViewModel extends GetxController {
  Outlet? outlet;
  WOutlet? wOutlet;
  int? selectedOutletId;
  RxBool isLocationChanged = false.obs;
  RxBool enableBtn = false.obs;
  RxBool isStartFlow = false.obs;
  RxBool isStartNotFlow = false.obs;
  RxDouble outletNearbyPos = 0.0.obs;
  int outletStatus = 0;

  // Location outletNearbyPos=Location();
  Rx<Set<Marker>> markers = RxSet<Marker>().obs;

  final Repository _repository;

  void setWOutlet(WOutlet? wOutlet) => this.wOutlet = wOutlet;

  void setOutlet(Outlet? outlet) => this.outlet = outlet;

  OutletSummaryViewModel(this._repository);

  Rx<Event<bool>> getSurveySavedWithEvent() =>
      _repository.getSurveySavedWithEvent();

  Rx<Event<String>> getMessage() => _repository.getMessage();

  Future<Object?> loadSelectedOutlet(
      int? selectedOutletId, SurveyType surveyType) async {
    try {
      if (selectedOutletId != null) {
        if (surveyType == SurveyType.MARKET_VISIT) {
          Outlet? outlet = await _repository.getOutlet(selectedOutletId);
          setSelectedOutlet(selectedOutletId);
          return outlet;
        } else {
          WOutlet? wOutlet = await _repository.getWOutlet(selectedOutletId);
          setSelectedOutlet(selectedOutletId);
          return wOutlet;
        }
      } else {
        return null;
      }
    } catch (e) {
      showToastMessage(e.toString());
      rethrow;
    }
  }

  void onNextClick(LatLng currentLocation) {
    LatLng? outletLocation;
    if (outlet != null) {
      outletLocation = LatLng(outlet!.lattitude!, outlet!.longitude!);
    } else if (wOutlet != null) {
      outletLocation = LatLng(wOutlet!.lattitude!, wOutlet!.longitude!);
    }

    double distance = Util.checkMetre(currentLocation, outletLocation);

    Configuration configuration = getConfiguration();

    if ((configuration.geoFenceRequired &&
            distance >= configuration.geoFenceMinRadius &&
            outletStatus <= 2) &&
        !isTestUser()) {
      setOutletNearbyPos(distance);
    } else {
      setStartFlow(true);
    }
  }

  void onStartNotFlow(LatLng currentLocation) {
    LatLng? outletLocation;
    if (outlet != null) {
      outletLocation = LatLng(outlet!.lattitude!, outlet!.longitude!);
    } else if (wOutlet != null) {
      outletLocation = LatLng(wOutlet!.lattitude!, wOutlet!.longitude!);
    }

    double distance = Util.checkMetre(currentLocation, outletLocation);

    Configuration configuration = getConfiguration();

    if ((configuration.geoFenceRequired &&
            distance >= configuration.geoFenceMinRadius &&
            outletStatus <= 2) &&
        !isTestUser()) {
      setOutletNearbyPos(distance);
    } else {
      setStartNotFlow(true);
    }
  }

  void setOutletNearbyPos(double distance) {
    outletNearbyPos.value = distance;
    outletNearbyPos.refresh();
  }

  void setStartFlow(bool value) {
    isStartFlow.value = value;
    isStartFlow.refresh();
  }

  void setSelectedOutlet(int? selectedOutlet) =>
      selectedOutletId = selectedOutlet;

  RxBool isLoading() => _repository.isLoading();

  void addMarker(Marker marker) {
    markers.value.clear();
    markers.value.add(marker);
    markers.refresh();
  }

  void postMarketVisit() => _repository.saveSurvey();

  void postWorkWith(WorkWithSingletonModel singletonModel) =>
      _repository.postWorkWith(singletonModel);

  void updateBtn(bool value) {
    enableBtn.value = value;
    enableBtn.refresh();
  }

  Configuration getConfiguration() => _repository.getConfiguration();

  void updateOutletStatusCode(int code) => outletStatus = code;

  void setStartNotFlow(bool value) {
    isStartNotFlow.value = value;
    isStartNotFlow.refresh();
  }

  void setOutletStatus(int code) => _repository.setOutletStatus(code);

  void setLoading(bool loading) => _repository.setLoading(loading);

  Rx<bool> getPostWorkWithSaved()=>_repository.postWorkWithSaved();

  bool isTestUser()=>_repository.isTestUser();
}

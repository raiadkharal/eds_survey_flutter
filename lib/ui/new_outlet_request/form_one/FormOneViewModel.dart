import 'package:eds_survey/Route.dart';
import 'package:eds_survey/data/db/entities/look_up_data.dart';
import 'package:eds_survey/data/db/entities/route.dart';
import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../data/models/PJPModel.dart';
import '../../../data/models/outlet_request/LookUpDataObject.dart';

class FormOneViewModel extends GetxController {
  final Repository _repository;
  Rx<LocationData?> currentLocation = Rx<LocationData?>(null);

  Rx<String> selectedJourneyPlan = "".obs;
  Rx<List<String>> selectedJourneyPlanDays = RxList<String>().obs;

  Rx<Set<Marker>> markers = RxSet<Marker>().obs;

  final Rx<LookUpData?> _lookUpData = Rx<LookUpData>(LookUpData());

  final Rx<List<LookUpDataObject>?> _routes = Rx<List<LookUpDataObject>>([]);

  List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  final List<LookUpDataObject> competitorCooler = [
    LookUpDataObject(value: "Yes"),
    LookUpDataObject(value: "No")
  ];
  final List<LookUpDataObject> journeyPlan = [
    LookUpDataObject(value: "Fixed"),
    LookUpDataObject(value: "Open")
  ];

  FormOneViewModel(this._repository);

  @override
  void onInit() {
    loadLookUpData();
    super.onInit();
  }

  void setLoading(bool value) {
    _repository.setLoading(value);
  }

  RxBool isLoading() => _repository.isLoading();

  void setCurrentLocation(LocationData locationData) {
    currentLocation.value = locationData;
    currentLocation.refresh();
  }

  void addMarker(Marker marker) {
    markers.value.clear();
    markers.value.add(marker);
    markers.refresh();
  }

  void toggleItem(String item) {
    if (selectedJourneyPlanDays.value.contains(item)) {
      selectedJourneyPlanDays.value.remove(item);
    } else {
      selectedJourneyPlanDays.value.add(item);
    }
    selectedJourneyPlanDays.refresh();
  }

  List<PJPModel> getPjpModels() {
    List<PJPModel> pjpModelList = [];
    ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    for (String selectedDay in selectedJourneyPlanDays.value) {
      switch (selectedDay) {
        case "Mon":
          pjpModelList.add(PJPModel.secondary(Constants.MONDAY, "Monday"));
          break;
        case "Tue":
          pjpModelList.add(PJPModel.secondary(Constants.MONDAY, "Tuesday"));
          break;
        case "Wed":
          pjpModelList.add(PJPModel.secondary(Constants.MONDAY, "Wednesday"));
          break;
        case "Thu":
          pjpModelList.add(PJPModel.secondary(Constants.MONDAY, "Thursday"));
          break;
        case "Fri":
          pjpModelList.add(PJPModel.secondary(Constants.MONDAY, "Friday"));
          break;
        case "Sat":
          pjpModelList.add(PJPModel.secondary(Constants.MONDAY, "Saturday"));
          break;
        case "Sun":
          pjpModelList.add(PJPModel.secondary(Constants.MONDAY, "Monday"));
          break;
      }
    }
    return pjpModelList;
  }

  Future<void> loadLookUpData() async {
    _repository.getLookUpData().then(
      (lookUpData) {
        _lookUpData.value = lookUpData;
        _lookUpData.refresh();
      },
    );

    _repository.getAllRoutes().then(
      (routes) {
        _routes.value = routes
            .map(
              (route) =>
                  LookUpDataObject(key: route.routeId, value: route.routeName),
            )
            .toList();
        _routes.refresh();
      },
    );
  }

  Rx<LookUpData?> getLookUpData() => _lookUpData;

  Rx<List<LookUpDataObject>?> getRoutes() => _routes;

  void setJourneyPlan(String value) {
    selectedJourneyPlan.value = value;
    selectedJourneyPlan.refresh();
  }
}

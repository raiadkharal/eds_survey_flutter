import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../data/models/PJPModel.dart';

class FormOneViewModel extends GetxController{

  final RxBool _isLoading=false.obs;
  Rx<LocationData?> currentLocation = Rx<LocationData?>(null);

  Rx<List<String>> selectedJourneyPlanDays = RxList<String>().obs;

  Rx<Set<Marker>> markers = RxSet<Marker>().obs;


  List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  final List<LookUpObject> items = [
   LookUpObject(key: 1,value: "Lookup Item 1"),
   LookUpObject(key: 2,value: "Lookup Item 2"),
   LookUpObject(key: 3,value: "Lookup Item 3"),
   LookUpObject(key: 4,value: "Lookup Item 4"),
   LookUpObject(key: 5,value: "Lookup Item 5"),
  ];

  FormOneViewModel();


  void setLoading(bool value){
    _isLoading.value=value;
    _isLoading.refresh();
  }

  RxBool isLoading()=>_isLoading;

  void setCurrentLocation(LocationData locationData){
    currentLocation.value=locationData;
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

  List<PJPModel> getPjpModels(){
    List<PJPModel> pjpModelList=[];
    ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    for(String selectedDay in selectedJourneyPlanDays.value){
      switch(selectedDay){
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
}
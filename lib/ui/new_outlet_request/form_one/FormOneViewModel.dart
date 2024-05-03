import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FormOneViewModel extends GetxController{

  final RxBool _isLoading=false.obs;
  Rx<LatLng>? currentLatLng;


  Rx<Set<Marker>> markers = RxSet<Marker>().obs;


  FormOneViewModel();


  void setLoading(bool value){
    _isLoading.value=value;
    _isLoading.refresh();
  }

  RxBool isLoading()=>_isLoading;

  void setCurrentLocation(LatLng currentLocation){
    currentLatLng=currentLocation.obs;
    currentLatLng?.refresh();
  }

  void addMarker(Marker marker) {
    markers.value.clear();
    markers.value.add(marker);
    markers.refresh();
  }
}
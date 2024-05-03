import 'package:eds_survey/components/dropdowns/OutlinedCustomDropdownMenu.dart';
import 'package:eds_survey/components/dropdowns/SimpleDropdownButton.dart';
import 'package:eds_survey/components/progress_dialogs/PregressDialog.dart';
import 'package:eds_survey/components/textfields/UnderlinedTextField.dart';
import 'package:eds_survey/ui/new_outlet_request/form_one/FormOneViewModel.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/Configuration.dart';
import '../../../utils/Util.dart';
import '../../../utils/Utils.dart';

class FormOne extends StatefulWidget {
  const FormOne({super.key});

  static const CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 10);

  @override
  State<FormOne> createState() => _FormOneState();
}

class _FormOneState extends State<FormOne> {
  final FormOneViewModel controller =
      Get.put<FormOneViewModel>(FormOneViewModel());
  final List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ];
  late GoogleMapController _controller;

  List<String> weekDays = ["M", "T", "w", "T", "F", "S", "S"];

  @override
  void initState() {
    super.initState();
    if(controller.currentLatLng!=null){
      _animateToSavedLocation(controller.currentLatLng!.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  surfaceTintColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 26.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 8,left: 16,right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const UnderlinedTextField(
                              hintText: 'Shop Name',
                            ),
                            const UnderlinedTextField(
                              hintText: 'Complete Address (min 25 characters',
                            ),
                            const UnderlinedTextField(
                              hintText: 'Landmark',
                            ),
                            const UnderlinedTextField(
                              hintText: 'Agreed Sales',
                            ),
                            const UnderlinedTextField(
                              hintText: 'Shop Radius',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "VPO Classification",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "City",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "Routes",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "Outlet Type",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "Market Type",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "Outlet Classification",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "Channel Type",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "Segment",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "Competitor Cooler",
                                textSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SimpleDropdownButton(
                                options: items,
                                hintText: "Journey Plan",
                                textSize: 18,
                              ),
                            ),
                            //Fixed Journey plan selection
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Wrap(
                                runAlignment: WrapAlignment.start,
                                clipBehavior: Clip.hardEdge,
                                children: weekDays
                                    .map((choice) => Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Checkbox(
                                                value: false,
                                                onChanged: (value) {},
                                              ),
                                            ),
                                            Text(choice)
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ),
                            const UnderlinedTextField(
                              hintText: 'Comment',
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: UnderlinedTextField(
                                    hintText: controller.currentLatLng == null
                                        ? "Geo Coordinates"
                                        : "${controller.currentLatLng!.value.latitude}/${controller.currentLatLng!.value.longitude}",
                                    helperText: "Accuracy: 12.765 meters",
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => _animateToCurrentLocation(),
                                    icon: const Icon(Icons.my_location_rounded))
                              ],
                            ),
                            Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Obx(
                                    () => GoogleMap(
                                      initialCameraPosition:
                                          FormOne._initialCameraPosition,
                                      scrollGesturesEnabled: false,
                                      markers: controller.markers.value,
                                      zoomControlsEnabled: false,
                                      mapToolbarEnabled: false,
                                      mapType: MapType.normal,
                                      onMapCreated: (mapController) async {
                                        _controller = mapController;
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5.0,
                                  right: 5.0,
                                  child: IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.locationArrow,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      try {
                                        launchMapUrl();
                                      } catch (e) {
                                        showToastMessage(e.toString());
                                      }
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50)),
                      width: 8,
                      height: 8,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50)),
                      width: 8,
                      height: 8,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Obx(() => controller.isLoading().value
            ? const SimpleProgressDialog()
            : const SizedBox())
      ],
    );
  }

  Future<LatLng?> _getCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location service not enabled");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location Permissions are denied");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permanently denied, we cannot request permissions. ");
    }
    controller.setLoading(true);
    final locationData = await Location.instance.getLocation();

    controller.setLoading(false);
    if (locationData.latitude != null && locationData.longitude != null) {
      return LatLng(locationData.latitude!, locationData.longitude!);
    }

    return null;
  }

  void launchMapUrl() async {
    // String url =
    //     "https://www.google.com/maps/dir/?api=1&destination=${currentLatLng?.latitude},${currentLatLng?.longitude}";
    // if (!await launchUrl(Uri.parse(url))) {
    //   throw 'Could not launch $url';
    // }
  }

  void _animateToCurrentLocation() async {
    LatLng? currentLatLng = await _getCurrentLocation();

    if (currentLatLng != null) {
      controller.setCurrentLocation(currentLatLng);
      controller.addMarker(Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(currentLatLng.latitude, currentLatLng.longitude),
      ));

      _controller.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
    }
  }

  void _animateToSavedLocation(LatLng? currentLatLng) async {
    if (currentLatLng != null) {
      controller.addMarker(Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(currentLatLng.latitude, currentLatLng.longitude),
      ));

      _controller.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
    }
  }

}

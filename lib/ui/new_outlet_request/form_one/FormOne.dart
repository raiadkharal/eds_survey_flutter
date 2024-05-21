import 'package:eds_survey/Route.dart';
import 'package:eds_survey/components/dropdown/SimpleDropdownButton.dart';
import 'package:eds_survey/components/progress_dialog/PregressDialog.dart';
import 'package:eds_survey/components/textfield/UnderlinedTextField.dart';
import 'package:eds_survey/data/models/FormOneModel.dart';
import 'package:eds_survey/ui/market_visit/Repository.dart';
import 'package:eds_survey/ui/new_outlet_request/form_one/FormOneViewModel.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:eds_survey/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../data/models/outlet_request/LookUpDataObject.dart';
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
      Get.put<FormOneViewModel>(FormOneViewModel(Get.find<Repository>()));

  FormOneSingletonModel formOneSingletonModel =
      FormOneSingletonModel.getInstance();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _shopNameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _landMarkController = TextEditingController();

  final TextEditingController _agreedSalesController = TextEditingController();

  final TextEditingController _shopRadiusController = TextEditingController();

  final TextEditingController _commentController = TextEditingController();

  final TextEditingController _latLngController = TextEditingController();

  String? _competitorsCooler, _journeyPlan;
  LookUpDataObject? _vpoClassification,
      _city,
      _route,
      _outletType,
      _marketType,
      _outletClassification,
      _channelType,
      _segment;

  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    _animateToSavedLocation(controller.currentLocation.value);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        title: Text(
          "OUTLET REQUEST",
          style: GoogleFonts.roboto(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //validate form and navigate to second form
          if (validateAndSaveFormData()) {
            Get.toNamed(Routes.outletRequestFormTwo);
          }
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      body: Stack(
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
                              top: 16.0, bottom: 8, left: 16, right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      UnderlinedTextField(
                                        controller: _shopNameController,
                                        labelText: 'Shop Name',
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter shop name";
                                          }
                                          return null;
                                        },
                                      ),
                                      UnderlinedTextField(
                                        controller: _addressController,
                                        labelText:
                                            'Complete Address (min 25 characters',
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length <= 25) {
                                            return "Address should be min 25 characters";
                                          }
                                          return null;
                                        },
                                      ),
                                      UnderlinedTextField(
                                        controller: _landMarkController,
                                        labelText: 'Landmark',
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Enter Landmark";
                                          }
                                          return null;
                                        },
                                      ),
                                      UnderlinedTextField(
                                        controller: _agreedSalesController,
                                        labelText: 'Agreed Sales',
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Enter Agreed Sales";
                                          }
                                          return null;
                                        },
                                      ),
                                      UnderlinedTextField(
                                        controller: _shopRadiusController,
                                        labelText: 'Shop Radius',
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Enter Shop Radius";
                                          }
                                          return null;
                                        },
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Obx(
                                          () => SimpleDropdownButton(
                                              options: controller
                                                      .getLookUpData()
                                                      .value
                                                      ?.vpo_classification ??
                                                  [],
                                              labelText: "VPO Classification",
                                              textSize: 18,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Enter VPO Classification";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                LookUpDataObject object =
                                                    value as LookUpDataObject;
                                                _vpoClassification = object;
                                              }),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Obx(
                                          () => SimpleDropdownButton(
                                              options: controller
                                                      .getLookUpData()
                                                      .value
                                                      ?.cities ??
                                                  [],
                                              labelText: "City",
                                              textSize: 18,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Enter City Name";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                LookUpDataObject object =
                                                    value as LookUpDataObject;
                                                _city = object;
                                              }),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Obx(
                                            () => SimpleDropdownButton(
                                              options: controller
                                                      .getRoutes()
                                                      .value ??
                                                  [],
                                              labelText: "Routes",
                                              textSize: 18,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Enter Route";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) => _route =
                                                  value as LookUpDataObject,
                                            ),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Obx(
                                          () => SimpleDropdownButton(
                                            options: controller
                                                    .getLookUpData()
                                                    .value
                                                    ?.outletTypes ??
                                                [],
                                            labelText: "Outlet Type",
                                            textSize: 18,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter Outlet Type";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) => _outletType =
                                                value as LookUpDataObject,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Obx(
                                          () => SimpleDropdownButton(
                                            options: controller
                                                    .getLookUpData()
                                                    .value
                                                    ?.market_types ??
                                                [],
                                            labelText: "Market Type",
                                            textSize: 18,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter Market Type";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) => _marketType =
                                                value as LookUpDataObject,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Obx(
                                          () => SimpleDropdownButton(
                                            options: controller
                                                    .getLookUpData()
                                                    .value
                                                    ?.outlet_classification ??
                                                [],
                                            labelText: "Outlet Classification",
                                            textSize: 18,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter Outlet Classification";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) =>
                                                _outletClassification =
                                                    value as LookUpDataObject,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Obx(
                                          () => SimpleDropdownButton(
                                            options: controller
                                                    .getLookUpData()
                                                    .value
                                                    ?.channels ??
                                                [],
                                            labelText: "Channel Type",
                                            textSize: 18,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter Channel Type";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) => _channelType =
                                                value as LookUpDataObject,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Obx(
                                            () => SimpleDropdownButton(
                                              options: controller
                                                      .getLookUpData()
                                                      .value
                                                      ?.channels ??
                                                  [],
                                              labelText: "Segment",
                                              textSize: 18,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Enter Segment";
                                                }
                                                return null;
                                              },
                                              onChanged: (value) => _segment =
                                                  value as LookUpDataObject,
                                            ),
                                          )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: SimpleDropdownButton(
                                          options: controller.competitorCooler,
                                          labelText: "Competitor Cooler",
                                          textSize: 18,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Enter Competitor Cooler";
                                            }
                                            return null;
                                          },
                                          onChanged: (value) =>
                                              _competitorsCooler =
                                                  (value as LookUpDataObject).value,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: SimpleDropdownButton(
                                            options: controller.journeyPlan,
                                            labelText: "Journey Plan",
                                            textSize: 18,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Enter Journey Plan";
                                              }
                                              return null;
                                            },
                                            onChanged: (value) {
                                              _journeyPlan = (value as LookUpDataObject).value;
                                              controller.setJourneyPlan(_journeyPlan??"");
                                            }),
                                      ),
                                      //Fixed Journey plan selection
                                      Obx(
                                          () =>
                                              controller.selectedJourneyPlan
                                                          .value ==
                                                      "Fixed"
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 16.0),
                                                      child: Wrap(
                                                        alignment:
                                                            WrapAlignment.start,
                                                        children:
                                                            controller.weekDays
                                                                .map(
                                                                    (choice) =>
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            SizedBox(
                                                                              height: 40,
                                                                              width: 40,
                                                                              child: Obx(
                                                                                () => Checkbox(
                                                                                  value: controller.selectedJourneyPlanDays.value.contains(choice),
                                                                                  onChanged: (value) => controller.toggleItem(choice),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Text(choice)
                                                                          ],
                                                                        ))
                                                                .toList(),
                                                      ),
                                                    )
                                                  : const SizedBox()),

                                      UnderlinedTextField(
                                        controller: _commentController,
                                        labelText: 'Comment',
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Obx(
                                              () => UnderlinedTextField(
                                                controller: _latLngController,
                                                enabled: false,
                                                labelText: "Geo Coordinates",
                                                helperText: controller
                                                            .currentLocation
                                                            .value
                                                            ?.accuracy !=
                                                        null
                                                    ? "Accuracy: ${controller.currentLocation.value?.accuracy?.toStringAsFixed(1)} meters"
                                                    : "Accuracy: 0.0 meters",
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return "Enter Geo Coordinates";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () =>
                                                  _animateToCurrentLocation(),
                                              icon: const Icon(
                                                  Icons.my_location_rounded))
                                        ],
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 10,
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
                                          // launchMapUrl();
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
      ),
    );
  }

  Future<LocationData?> _getCurrentLocation() async {
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
    // if (locationData.latitude != null && locationData.longitude != null) {
    //   return LatLng(locationData.latitude!, locationData.longitude!);
    // }

    return locationData;
  }

  void _animateToCurrentLocation() async {
    LocationData? locationData = await _getCurrentLocation();

    if (locationData != null) {
      controller.setCurrentLocation(locationData);
      _latLngController.text =
          "${locationData.latitude}/${locationData.longitude}";
      controller.addMarker(Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(locationData.latitude!, locationData.longitude!),
      ));

      _controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(locationData.latitude!, locationData.longitude!), 15));
    }
  }

  void _animateToSavedLocation(LocationData? locationData) async {
    if (locationData != null) {
      controller.addMarker(Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(locationData.latitude!, locationData.longitude!),
      ));

      _controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(locationData.latitude!, locationData.longitude!), 15));
    }
  }

  bool validateAndSaveFormData() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState != null) {
      if (!_formKey.currentState!.validate()) {
        showToastMessage("Please enter all the fields");
        return false;
      }
    } else {
      return false;
    }

    formOneSingletonModel.outletName = _shopNameController.text.trim();

    if (_addressController.text.trim().isNotEmpty) {
      formOneSingletonModel.outletAddress = _addressController.text.trim();
    } else {
      formOneSingletonModel.outletAddress = "";
    }

    formOneSingletonModel.landmark = _landMarkController.text.trim();

    if (_agreedSalesController.text.trim().isNotEmpty) {
      formOneSingletonModel.agreedSalesVolume =
          int.parse(_agreedSalesController.text.trim());
    } else {
      formOneSingletonModel.agreedSalesVolume = null;
    }

    if (_shopRadiusController.text.trim().isNotEmpty) {
      formOneSingletonModel.radius =
          double.parse(_shopRadiusController.text.trim());
    } else {
      formOneSingletonModel.radius = null;
    }

    formOneSingletonModel.vpoClassification = _vpoClassification?.value;
    formOneSingletonModel.vpoClassificationId = _vpoClassification?.key;

    formOneSingletonModel.city = _city?.value;
    formOneSingletonModel.cityId = _city?.key;

    formOneSingletonModel.routes = _route?.value;
    formOneSingletonModel.routeId = _route?.key;

    formOneSingletonModel.outletType = _outletType?.value;
    formOneSingletonModel.outletTypeId = _outletType?.key;

    formOneSingletonModel.marketType = _marketType?.value;
    formOneSingletonModel.marketTypeId = _marketType?.key;

    formOneSingletonModel.outletClassification = _outletClassification?.value;
    formOneSingletonModel.outletClassificationId = _outletClassification?.key;

    formOneSingletonModel.channelType = _channelType?.value;
    formOneSingletonModel.channelId = _channelType?.key;

    formOneSingletonModel.comments = _commentController.text.trim();

    formOneSingletonModel.competitorsCooler =
        _competitorsCooler?.trim() == "Yes" ? true : false;

    if (_journeyPlan!.isEmpty) {
      formOneSingletonModel.journeyPlan = null;
      formOneSingletonModel.pjpModels = null;
    } else {
      if (_journeyPlan == "Fixed") {
        formOneSingletonModel.journeyPlan = true;
      } else {
        formOneSingletonModel.journeyPlan = false;
      }
    }

    if (controller.currentLocation.value == null) {
      formOneSingletonModel.lat = 0.0;
      formOneSingletonModel.lng = 0.0;
    } else {
      formOneSingletonModel.lat = controller.currentLocation.value!.latitude;
      formOneSingletonModel.lng = controller.currentLocation.value!.longitude;
    }

    if (_journeyPlan == "Fixed") {
      if (controller.getPjpModels().isNotEmpty) {
        formOneSingletonModel.pjpModels = controller.getPjpModels();
      } else {
        formOneSingletonModel.pjpModels = [];
      }
    }

    formOneSingletonModel.requestTypeId = Constants.NEW_OUTLET_REQUEST_TYPE_ID;

    return true;
  }
}

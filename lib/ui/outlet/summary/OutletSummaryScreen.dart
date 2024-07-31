import 'dart:async';

import 'package:eds_survey/Route.dart';
import 'package:eds_survey/data/SurveySingletonModel.dart';
import 'package:eds_survey/data/models/Configuration.dart';
import 'package:eds_survey/ui/outlet/merchandising/MerchandisingScreen.dart';
import 'package:eds_survey/ui/outlet/outlet_list/OutletsScreen.dart';
import 'package:eds_survey/ui/outlet/summary/OutletSummaryViewModel.dart';
import 'package:eds_survey/utils/AlertDialogManager.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:eds_survey/utils/Enums.dart';
import 'package:eds_survey/utils/PreferenceUtil.dart';
import 'package:eds_survey/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/navigation_drawer/MyNavigationDrawer.dart';
import '../../../components/progress_dialog/PregressDialog.dart';
import '../../../data/WorkWithSingletonModel.dart';
import '../../../data/db/entities/outlet.dart';
import '../../../data/db/entities/workwith/WOutlet.dart';
import '../../../utils/Util.dart';

class OutletSummaryScreen extends StatefulWidget {
  const OutletSummaryScreen({super.key});

  static const CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 10);

  @override
  State<OutletSummaryScreen> createState() => _OutletSummaryScreenState();
}

class _OutletSummaryScreenState extends State<OutletSummaryScreen> {
  late GoogleMapController _controller;

  LatLng? outletLatLng, currentLatLng;

  late Outlet outlet;

  late WOutlet wOutlet;

  int statusId = 1;

  int startLocationTime = 0;

  int endLocationTime = 0;

  int alertDialogCount = 0;

  bool isFakeLocation = false;

  int? notFlowReasonCode;

  final OutletSummaryViewModel controller =
      Get.put(OutletSummaryViewModel(Get.find()));

  late final int outletId;
  late final SurveyType surveyType;

  @override
  void initState() {
    List<dynamic> args = Get.arguments;
    outletId = args[0];
    surveyType = args[1];
    SurveySingletonModel.getInstance().setStartDateTime(DateTime.now());
    WorkWithSingletonModel.getInstance()
        .setStartTime(DateTime.now().millisecondsSinceEpoch);
    setObservers();
    _setLocationCallback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        baseContext: context,
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          title: Text(
            "EDS Survey",
            style: GoogleFonts.roboto(color: Colors.white),
          )),
      body: FutureBuilder<Object?>(
        future: controller.loadSelectedOutlet(outletId, surveyType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (surveyType == SurveyType.MARKET_VISIT) {
              outlet = (snapshot.requireData as Outlet);
              controller.setOutlet(outlet);
              SurveySingletonModel.getInstance().setOutletId(outlet.outletId);
              SurveySingletonModel.getInstance()
                  .setOutletLatitude(outletLatLng?.latitude);
              SurveySingletonModel.getInstance()
                  .setOutletLongitude(outletLatLng?.longitude);
            } else {
              wOutlet = (snapshot.requireData as WOutlet);
              controller.setWOutlet(wOutlet);
              SurveySingletonModel.getInstance().setOutletId(wOutlet.outletId);
              SurveySingletonModel.getInstance()
                  .setOutletLatitude(outletLatLng?.latitude);
              SurveySingletonModel.getInstance()
                  .setOutletLongitude(outletLatLng?.longitude);
            }
            return Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 250,
                            child: Obx(
                              () => GoogleMap(
                                initialCameraPosition:
                                    OutletSummaryScreen._initialCameraPosition,
                                scrollGesturesEnabled: false,
                                markers: controller.markers.value,
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                                mapType: MapType.normal,
                                onMapCreated: (mapController) async {
                                  _controller = mapController;
                                  // final Uint8List? markerIcon = await Utils.getBytesFromAsset('assets/images/ic_location.png', 100);
                                  if (surveyType == SurveyType.MARKET_VISIT) {
                                    if (outlet.lattitude != null &&
                                        outlet.longitude != null) {
                                      controller.addMarker(Marker(
                                        markerId: const MarkerId("location"),
                                        position: LatLng(outlet.lattitude!,
                                            outlet.longitude!),
                                      ));
                                      _controller.animateCamera(
                                          CameraUpdate.newLatLngZoom(
                                              LatLng(outlet.lattitude!,
                                                  outlet.longitude!),
                                              15));
                                    }
                                  } else {
                                    if (wOutlet.lattitude != null &&
                                        wOutlet.longitude != null) {
                                      controller.addMarker(Marker(
                                        markerId: const MarkerId("location"),
                                        position: LatLng(wOutlet.lattitude!,
                                            wOutlet.longitude!),
                                      ));
                                      _controller.animateCamera(
                                          CameraUpdate.newLatLngZoom(
                                              LatLng(wOutlet.lattitude!,
                                                  wOutlet.longitude!),
                                              15));
                                    }
                                  }
                                },
                              ),
                            )),
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
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "OUTLET SUMMARY",
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Outlet Name: ",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Outlet Code: ",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "MTD Sales: ",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Route Name: ",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "No of coolers: ",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Channel",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Address",
                                  style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    surveyType == SurveyType.MARKET_VISIT
                                        ? outlet.outletName ?? "null"
                                        : wOutlet.outletName ?? "null",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    surveyType == SurveyType.MARKET_VISIT
                                        ? outlet.outletCode ?? "null"
                                        : wOutlet.outletCode ?? "null",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "${surveyType == SurveyType.MARKET_VISIT ? outlet.mtdSale ?? 0.0 : wOutlet.mtdSale ?? 0.0}",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    surveyType == SurveyType.MARKET_VISIT
                                        ? outlet.routeName ?? "null"
                                        : wOutlet.routeName ?? "null",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "${surveyType == SurveyType.MARKET_VISIT ? outlet.totalCoolers ?? 0 : wOutlet.totalCoolers ?? 0}",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    surveyType == SurveyType.MARKET_VISIT
                                        ? outlet.channelName ?? "null"
                                        : wOutlet.channelName ?? "null",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    surveyType == SurveyType.MARKET_VISIT
                                        ? outlet.address ?? "null"
                                        : wOutlet.address ?? "null",
                                    style: GoogleFonts.roboto(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return ['Outlet Closed', 'No Time']
                                    .map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(item),
                                    ),
                                  );
                                }).toList();
                              },
                              onSelected: (selectedReason) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    insetPadding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    title: const Text("Warning!"),
                                    content: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Are you sure you want to take an action?",
                                            style: GoogleFonts.roboto(
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(),
                                                  child: Text(
                                                    "No",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Map<String, int> hashMap =
                                                        {};
                                                    hashMap['Outlet Closed'] =
                                                        2;
                                                    hashMap['No Time'] = 3;

                                                    notFlowReasonCode =
                                                        hashMap[selectedReason];
                                                    Navigator.of(context).pop();
                                                    notFlowClick();
                                                  },
                                                  child: Text(
                                                    "Yes",
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              offset: const Offset(0, -120),
                              child: Container(
                                color: Colors.blueAccent,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "CAN'T START FLOW",
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                ),
                              ), // Adjust the vertical offset as needed
                            ),
                            InkWell(
                              onTap: () => onStartFlowClick(),
                              child: Container(
                                color: Colors.blueAccent,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "START FLOW",
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Obx(
                  () => controller.isLoading().value
                      ? const SimpleProgressDialog()
                      : const SizedBox(),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> startFlowToNext() async {
    double distance = Util.checkMetre(currentLatLng, outletLatLng);

    if (surveyType == SurveyType.SURVEY_WITH) {
      try {
        WorkWithSingletonModel.getInstance().setOutletId(wOutlet.outletId);
        WorkWithSingletonModel.getInstance()
            .setOutletLatitude(wOutlet.lattitude);
        WorkWithSingletonModel.getInstance()
            .setOutletLongitude(wOutlet.longitude);

        WorkWithSingletonModel.getInstance().setLocation(
            currentLatLng?.latitude ?? 0.0, currentLatLng?.longitude ?? 0.0);
        WorkWithSingletonModel.getInstance().setDistance(distance);
        WorkWithSingletonModel.getInstance().setStatusId(statusId);
        WorkWithSingletonModel.getInstance().setStatus(statusId);

        if (statusId == 1) {
          final result = await Get.toNamed(Routes.merchandising,
              arguments: [wOutlet.outletId, surveyType]);
          if (result == "ok") {
            Get.back(result: result);
          }
        } else {
          // controller.setLoading(true);
          controller.postWorkWith(WorkWithSingletonModel.getInstance());
        }
      } catch (e) {
        controller.setLoading(false);
        showToastMessage(e.toString());
      }
    } else if (surveyType == SurveyType.MARKET_VISIT) {
      try {
        SurveySingletonModel.getInstance().setOutletId(outlet.outletId);
        SurveySingletonModel.getInstance().setOutletLatitude(outlet.lattitude);
        SurveySingletonModel.getInstance().setOutletLongitude(outlet.longitude);

        SurveySingletonModel.getInstance().setDistance(distance);
        SurveySingletonModel.getInstance().setStatusId(statusId);
        SurveySingletonModel.getInstance().setLocation(currentLatLng);

        if (surveyType == SurveyType.MARKET_VISIT) {
          if (outlet.lattitude != null && outlet.longitude != null) {
            outletLatLng = LatLng(outlet.lattitude!, outlet.longitude!);
          }
        } else {
          if (outlet.lattitude != null && outlet.longitude != null) {
            outletLatLng = LatLng(outlet.lattitude!, outlet.longitude!);
          }
        }
        if (statusId == 1) {
          final result = await Get.toNamed(Routes.merchandising,
              arguments: [outlet.outletId, surveyType]);

          if (result == "ok") {
            Get.back(result: result);
          }
        } else {
          controller.postMarketVisit();
        }
      } catch (e) {
        controller.setLoading(false);
        showToastMessage(e.toString());
      }
    }
  }

  void onStartFlowClick() {
    PreferenceUtil preferenceUtil = Get.find<PreferenceUtil>();
    preferenceUtil.setOutletStatus(1);

    if (!isFakeLocation) {
      //TODO-add auto time check here, if not auto time then show dialog message and return
      bool autoTime = true;
      if (!autoTime) {
        return;
      }
      controller.updateOutletStatusCode(1);

      if (currentLatLng != null) {
        controller.onNextClick(currentLatLng!);
      } else {
        _setLocationCallback();
      }
    } else {
      showToastMessage("You are using fake GPS");
    }
  }

  void notFlowClick() async {
    if (!isFakeLocation) {
      bool isAutoTimeEnabled = await _checkAutoTime();

      if (!isAutoTimeEnabled && !controller.isTestUser()) {
        //TODO-show dialog message
        showToastMessage("Please enable auto date time");
        return;
      }
      controller.updateOutletStatusCode(1);

      if (currentLatLng != null) {
        controller.onStartNotFlow(currentLatLng!);
      } else {
        _setLocationCallback();
      }
    } else {
      showToastMessage("You are using fake GPS");
    }
  }

  Future<bool> _checkAutoTime() async {
    const platform = MethodChannel('com.optimus.time/autoTime');

    bool isAutoTimeEnabled;
    try {
      final bool result = await platform.invokeMethod('isAutoDateTimeEnabled');
      isAutoTimeEnabled = result;
    } on PlatformException catch (e) {
      isAutoTimeEnabled = false;
    } on Exception catch (e) {
      e.printInfo();
      isAutoTimeEnabled = false;
    }

    return isAutoTimeEnabled;
  }

  Future<LocationData> _setLocationCallback() async {
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
    isFakeLocation = locationData.isMock ?? false;

    controller.setLoading(false);
    if (locationData.latitude != null && locationData.longitude != null) {
      currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);
    }

    if (surveyType == SurveyType.MARKET_VISIT) {
      if (outlet.lattitude != null && outlet.longitude != null) {
        outletLatLng = LatLng(outlet.lattitude!, outlet.longitude!);
      }
    } else {
      if (wOutlet.lattitude != null && wOutlet.longitude != null) {
        outletLatLng = LatLng(wOutlet.lattitude!, wOutlet.longitude!);
      }
    }

    // controller.setLoading(true);
    double meters = Util.checkMetre(currentLatLng, outletLatLng);

    Configuration configuration = controller.getConfiguration();

    startLocationTime = DateTime.now().millisecondsSinceEpoch;
    if ((meters > configuration.geoFenceMinRadius &&
            startLocationTime > endLocationTime) &&
        !controller.isTestUser()) {
      showOutsideBoundaryDialog(alertDialogCount, meters.toString());
    } else if (meters <= configuration.geoFenceMinRadius ||
        !controller.isTestUser()) {
      controller.updateBtn(true);
    }

    return locationData;
  }

  void launchMapUrl() async {
    String url =
        "https://www.google.com/maps/dir/?api=1&destination=${outlet.lattitude},${outlet.longitude}";
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void showOutsideBoundaryDialog(int repeat, String distance) {
    if (repeat < 2) {
      alertDialogCount++;
      // showToastMessage(
      //     "Your are $distance away from the outlet please go to outlet location and try again");

      controller.setLoading(true);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Text("Warning!", style: GoogleFonts.roboto()),
          content: Text(
            "You are $distance away from the retailer's defined boundary.\nPress Ok to continue" +
                "\nCurrent LatLng ::  ${currentLatLng?.latitude} , ${currentLatLng?.longitude} \nAlert Count :: ${repeat + 1}",
            style: GoogleFonts.roboto(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _setLocationCallback();
                },
                child: Text(
                  "Ok",
                  style: GoogleFonts.roboto(
                      color: Colors.grey.shade800, fontSize: 16),
                ))
          ],
        ),
      );
    }
  }

  void setStartNotFlow() {
    SurveySingletonModel.getInstance().setStatusId(notFlowReasonCode!);
    controller.setOutletStatus(notFlowReasonCode!);
    double distance = Util.checkMetre(currentLatLng, outletLatLng);

    if (currentLatLng != null) {
      if (surveyType == SurveyType.SURVEY_WITH) {
        try {
          WorkWithSingletonModel.getInstance()
              .setEndTime(DateTime.now().millisecondsSinceEpoch);
          WorkWithSingletonModel.getInstance().setOutletId(wOutlet.outletId);
          WorkWithSingletonModel.getInstance()
              .setOutletLatitude(wOutlet.lattitude);
          WorkWithSingletonModel.getInstance()
              .setOutletLongitude(wOutlet.longitude);

          WorkWithSingletonModel.getInstance().setDistance(distance);
          WorkWithSingletonModel.getInstance().setStatusId(statusId);
          WorkWithSingletonModel.getInstance().setStatus(statusId);
          WorkWithSingletonModel.getInstance().setLocation(
              currentLatLng?.latitude ?? 0.0, currentLatLng?.longitude ?? 0.0);

          controller.postWorkWith(WorkWithSingletonModel.getInstance());
        } catch (e) {
          controller.setLoading(false);
          showToastMessage("Work with Exception: ${e.toString()}");
        }
      } else if (surveyType == SurveyType.MARKET_VISIT) {
        try {
          SurveySingletonModel.getInstance().setOutletId(outlet.outletId);
          SurveySingletonModel.getInstance()
              .setOutletLatitude(outlet.lattitude);
          SurveySingletonModel.getInstance()
              .setOutletLongitude(outlet.longitude);
          SurveySingletonModel.getInstance().setDistance(distance);

          SurveySingletonModel.getInstance().setLocation(currentLatLng);
          controller.postMarketVisit();
        } catch (e) {
          controller.setLoading(false);
          showToastMessage("Market Visit Exception: ${e.toString()}");
        }
      }
    } else {
      _setLocationCallback();
    }
  }

  void setObservers() {
    debounce(controller.isStartFlow, (value) {
      if (value) {
        startFlowToNext();
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.isStartNotFlow, (value) {
      if (value) {
        setStartNotFlow();
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.outletNearbyPos, (distance) {
      if (currentLatLng != null && outletLatLng != null) {
        AlertDialogManager.getInstance().showLocationMissMatchAlertDialog(
            context, currentLatLng!, outletLatLng!);
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getSurveySavedWithEvent(), (event) {
      if (event.getContentIfNotHandled() != null) {
        controller.setOutletStatus(1);
        // navigate back to outlet list screen
        // Get.back(result: "ok");
        Get.until((route) => Get.currentRoute == Routes.outletList);
        SurveySingletonModel.getInstance().reset();
      }
    }, time: const Duration(milliseconds: 200));

    debounce(controller.getPostWorkWithSaved(), (aBoolean) {
      if (aBoolean) {
        controller.setOutletStatus(1);
        // navigate back to outlet list screen
        // Get.back(result: "ok");
        Get.until((route) => Get.currentRoute == Routes.outletList);
        WorkWithSingletonModel.getInstance().reset();
      }
    }, time: const Duration(milliseconds: 100));

    debounce(controller.getMessage(), (event) {
      if (!event.hasBeenHandled) {
        showToastMessage(event.peekContent());
      }
    }, time: const Duration(milliseconds: 200));
  }
}

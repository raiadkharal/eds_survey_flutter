import 'dart:async';
import 'dart:typed_data';

import 'package:eds_survey/components/buttons/custom_button.dart';
import 'package:eds_survey/ui/market_visit/gandola/GandolaScreen.dart';
import 'package:eds_survey/ui/outlet/merchandising/MerchandisingScreen.dart';
import 'package:eds_survey/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/navigation_drawer/nav_drawer.dart';
import '../../../utils/Util.dart';

class OutletSummaryScreen extends StatefulWidget {
  const OutletSummaryScreen({super.key});

  @override
  State<OutletSummaryScreen> createState() => _OutletSummaryScreenState();
}

class _OutletSummaryScreenState extends State<OutletSummaryScreen> {
  late GoogleMapController _controller;
  final double latitude = 37.7749;
  final double longitude = -122.4194;

  static const CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 10);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(
        baseContext: context,
      ),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: const Icon(
          //       Icons.menu,
          //       color: Colors.white,
          //     )),
          title: Expanded(
              child: Text(
                "EDS Survey",
                style: GoogleFonts.roboto(color: Colors.white),
              ))),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  scrollGesturesEnabled: false,
                  markers: markers,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  onMapCreated: (controller) async {
                    _controller = controller;
                    Position position = await _determinePosition();
                    // final Uint8List? markerIcon = await Utils.getBytesFromAsset('assets/images/ic_location.png', 100);
                    markers.add(Marker(
                        markerId: const MarkerId("currentlocation"),
                        position:
                        LatLng(position.latitude, position.longitude)));

                    _controller.animateCamera(CameraUpdate.newLatLngZoom(
                        LatLng(position.latitude, position.longitude), 15));

                    setState(() {});
                  },
                ),
              ),
              Positioned(
                bottom: 5.0,
                right: 5.0,
                child: IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.locationArrow, color: Colors.black,),
                  onPressed: () {
                    launchMapUrl();
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "SB Traders(Risen)",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "4000101",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "0.0",
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "20008-LHR-3-Muhammad Hassan",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "0",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Super Market Chain",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Shadbagh",
                        style: GoogleFonts.roboto(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
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
                  MaterialButton(
                      onPressed: () {},
                      color: Colors.blue,
                      child: Text(
                        "CAN'T START FLOW",
                        style: GoogleFonts.roboto(color: Colors.white),
                      )),
                  MaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const MerchandisingScreen(),));
                      },
                      color: Colors.blue,
                      child: Text(
                        "START FLOW",
                        style: GoogleFonts.roboto(color: Colors.white),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
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

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void launchMapUrl() async {
    String url =
        "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude";
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}

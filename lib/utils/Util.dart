import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class Util {
  static const String DATE_FORMAT_1 = "MM/dd/yy";
  static const String DATE_FORMAT_2 = "MMM dd";
  static const String DATE_FORMAT_3 = "MMM-dd";
  static const String DATE_FORMAT_5 = "hh:mm a";
  static const String DATE_FORMAT_4 = "MM/dd/yyyy hh:mm a";
  static const String DATE_FORMAT_6 = "yyyy-MM-dd'T'HH:mm:ss.SSS";

  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  static bool isDateToday(int timestamp) {
    // Convert timestamp to DateTime
    DateTime dateTimeFromTimestamp =
        DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Get current date
    DateTime currentDate = DateTime.now();

    // Check if the date from the timestamp is the same as the current date
    return isSameDate(dateTimeFromTimestamp, currentDate);
  }

  static String formatDate(String format, int? dateInMilli) {
    if (dateInMilli == null) {
      return "";
    }
    try {
      // Convert timestamp to DateTime
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(dateInMilli);

      // Format the date to given format
      String formattedDate = DateFormat(format).format(dateTime);
      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  // Future<String> imageFileToBase64(File imageFile) async {
  //   List<int> imageBytes = await imageFile.readAsBytes();
  //   String base64Image = base64Encode(imageBytes);
  //   return base64Image;
  // }

  static Future<String?> imageFileToBase64(String filePath) async {
    try {
      File imageFile = File(filePath);
      List<int> imageBytes = await imageFile.readAsBytes();
      return base64Encode(imageBytes);
    }catch(e){
      showToastMessage("Something went wrong. Please try again later");
    }
    return null;
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static void showToastMessage(String message){
    Fluttertoast.showToast(msg: message);
  }

  static double checkMetre(LatLng? from, LatLng? to) {
    if (from != null && to != null) {
      double distance = Geolocator.distanceBetween(
          from.latitude, from.longitude, to.latitude, to.longitude);
      //ensure only 2 decimal digits
      return double.parse(distance.toStringAsFixed(2));
    } else {
      return 0.0;
    }
  }

  static String formattedDistance(double distance) {
    double distanceInKm = distance / 1000;
    return "${distanceInKm.toStringAsFixed(2)} km";
  }

}

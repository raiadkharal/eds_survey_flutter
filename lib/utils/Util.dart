import 'dart:ui' as ui;

import 'package:flutter/services.dart';

 class Util{
  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  static bool isDateToday(int timestamp){

    // Convert timestamp to DateTime
    DateTime dateTimeFromTimestamp = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Get current date
    DateTime currentDate = DateTime.now();

    // Check if the date from the timestamp is the same as the current date
    return isSameDate(dateTimeFromTimestamp, currentDate);
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

}
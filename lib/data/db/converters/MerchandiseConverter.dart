import 'package:floor/floor.dart';
import 'dart:convert';

import '../../models/MerchandisingImage.dart';

class MerchandiseConverter extends TypeConverter<List<MerchandisingImage>, String> {
  @override
  List<MerchandisingImage> decode(String? databaseValue) {
    if (databaseValue == null) return [];
    List<dynamic> list = json.decode(databaseValue);
    return list.map((item) => MerchandisingImage.fromJson(item)).toList();
  }

  @override
  String encode(List<MerchandisingImage>? value) {
    if (value == null) return "";
    return json.encode(value.map((item) => item.toJson()).toList());
  }
}


import 'dart:convert';

import 'package:floor/floor.dart';

import '../../models/LookUpObject.dart';

class LookUpConverter extends TypeConverter<List<LookUpObject>, String> {
  @override
  List<LookUpObject> decode(String databaseValue) {
    List<dynamic> list = json.decode(databaseValue);
    return list.map((item) => LookUpObject.fromJson(item)).toList();
  }

  @override
  String encode(List<LookUpObject> value) {
    return json.encode(value.map((item) => item.toJson()).toList());
  }
}

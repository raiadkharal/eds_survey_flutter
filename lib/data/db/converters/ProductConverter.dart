import 'package:floor/floor.dart';
import 'dart:convert';

import '../../models/Product.dart';

class ProductConverter extends TypeConverter<List<Product>, String> {
  @override
  List<Product> decode(String? databaseValue) {
    if (databaseValue == null) return [];
    List<dynamic> list = json.decode(databaseValue);
    return list.map((item) => Product.fromJson(item)).toList();
  }

  @override
  String encode(List<Product>? value) {
    if (value == null) return "";
    return json.encode(value.map((item) => item.toJson()).toList());
  }
}

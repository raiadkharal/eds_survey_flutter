import 'dart:convert';

import 'package:eds_survey/data/db/converters/LookUpConverter.dart';
import 'package:eds_survey/data/db/converters/ProductConverter.dart';
import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'look_up_data.g.dart';

@JsonSerializable()
class LookUpData {
  int id;

  List<LookUpObject>? packages;

  List<LookUpObject>? brands;

  List<Product>? products;

  LookUpData({
    this.id = 0,
    this.packages,
    this.brands,
    this.products,
  });

  factory LookUpData.fromJson(Map<String, dynamic> json) =>
      _$LookUpDataFromJson(json);

  Map<String, dynamic> toJson() => _$LookUpDataToJson(this);
}

import 'dart:convert';

import 'package:eds_survey/data/models/LookUpObject.dart';
import 'package:eds_survey/data/models/Product.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../models/outlet_request/LookUpDataObject.dart';

part 'look_up_data.g.dart';

@JsonSerializable()
class LookUpData {
  int id;

  List<LookUpObject>? packages;

  List<LookUpObject>? brands;

  List<Product>? products;

  List<LookUpDataObject>? vpo_classification;

  List<LookUpDataObject>? trade_classification;

  List<LookUpDataObject>? outlet_classification;

  List<LookUpDataObject>? channels;

  List<LookUpDataObject>? market_types;


  List<LookUpDataObject>? cities;

  List<LookUpDataObject>? outletTypes;


  LookUpData({
    this.id = 0,
    this.packages,
    this.brands,
    this.products,
    this.vpo_classification,
    this.trade_classification,
    this.outlet_classification,
    this.channels,
    this.market_types,
    this.cities,
    this.outletTypes,
  });

  factory LookUpData.fromJson(Map<String, dynamic> json) =>
      _$LookUpDataFromJson(json);

  Map<String, dynamic> toJson() => _$LookUpDataToJson(this);
}

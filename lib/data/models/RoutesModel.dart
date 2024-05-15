import 'dart:core';

import 'package:eds_survey/data/models/BaseResponse.dart';
import 'package:json_annotation/json_annotation.dart';

import '../db/entities/outlet_request/OutletTable.dart';
import 'DocumentTable.dart';

part 'RoutesModel.g.dart';

@JsonSerializable()
class RoutesModel extends BaseResponse {

  List<OutletTable>? outlets;
  List<DocumentTable>? documents;

  RoutesModel({this.outlets, this.documents});

  factory RoutesModel.fromJson(Map<String, dynamic> json) =>
      _$RoutesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutesModelToJson(this);
}

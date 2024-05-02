import 'package:json_annotation/json_annotation.dart';

import '../../../utils/Utils.dart';

part 'outlet.g.dart';

@JsonSerializable()
class Outlet {
  @JsonKey(name: 'outletId')
  int? outletId;

  @JsonKey(name: 'routeId')
  int? routeId;

  @JsonKey(name: 'outletCode')
  String? outletCode;

  @JsonKey(name: 'outletName')
  String? outletName;

  @JsonKey(name: 'outletChannel')
  String? channelName;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'city')
  String? city;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'location')
  String? location;

  @JsonKey(name: 'distributionId')
  int? distributionId;

  @JsonKey(name: 'distributionName')
  String? distributionName;

  @JsonKey(name: 'lattitude')
  double? lattitude;

  @JsonKey(name: 'longitude')
  double? longitude;

  @JsonKey(name: 'totalCoolers')
  int? totalCoolers;

  @JsonKey(name: 'routeName')
  String? routeName;

  @JsonKey(name: 'lastVisit')
  String? lastVisit;

  @JsonKey(name: 'isZeroSaleOutlet', fromJson: boolFromInt, toJson: boolToInt)
  bool? isZeroSaleOutlet;

  @JsonKey(name: 'isPJP', fromJson: boolFromInt, toJson: boolToInt)
  bool? isPJP;

  @JsonKey(
      name: 'mvLastVisitSameMonth', fromJson: boolFromInt, toJson: boolToInt)
  bool? alreadyVisit;

  @JsonKey(name: 'mtdSale')
  double? mtdSale;

  @JsonKey(name: 'visitTimeLat')
  double? visitTimeLat;

  @JsonKey(name: 'visitTimeLng')
  double? visitTimeLng;

  @JsonKey(name: 'synced', fromJson: boolFromInt, toJson: boolToInt)
  bool? synced;

  @JsonKey(name: 'surveyTaken', fromJson: boolFromInt, toJson: boolToInt)
  bool? surveyTaken;

  Outlet(
    this.outletId,
    this.routeId,
    this.outletCode,
    this.outletName,
    this.channelName,
    this.status,
    this.city,
    this.address,
    this.location,
    this.distributionId,
    this.distributionName,
    this.lattitude,
    this.longitude,
    this.totalCoolers,
    this.routeName,
    this.lastVisit,
    this.isZeroSaleOutlet,
    this.isPJP,
    this.alreadyVisit,
    this.mtdSale,
    this.visitTimeLat,
    this.visitTimeLng,
    this.synced,
    this.surveyTaken,
  );

  factory Outlet.fromJson(Map<String, dynamic> json) => _$OutletFromJson(json);

  Map<String, dynamic> toJson() => _$OutletToJson(this);
}

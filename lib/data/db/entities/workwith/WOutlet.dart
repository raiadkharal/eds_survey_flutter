import 'package:json_annotation/json_annotation.dart';

import '../../../../utils/Utils.dart';

part 'WOutlet.g.dart';

@JsonSerializable()
class WOutlet {
  @JsonKey(name: 'outletId')
  final int outletId;

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

  @JsonKey(name: 'longitude')
   double? longitude;

  @JsonKey(name: 'lattitude')
   double? lattitude;

  @JsonKey(name: 'routeName')
   String? routeName;

   double? visitTimeLat;
   double? visitTimeLng;

  @JsonKey(name: 'surveyTaken',fromJson: boolFromInt,toJson: boolToInt)
  bool? surveyTaken;

  @JsonKey(name: 'lastVisit')
   String? lastVisit;

  @JsonKey(name: 'totalCoolers')
   int? totalCoolers;

  @JsonKey(name: 'isZeroSaleOutlet',fromJson: boolFromInt,toJson: boolToInt)
   bool? isZeroSaleOutlet;

  @JsonKey(name: 'wwLastVisitSameMonth',fromJson: boolFromInt,toJson: boolToInt)
   bool? alreadyVisit;

  @JsonKey(name: 'mtdSale')
   double? mtdSale;

  @JsonKey(name: 'isPJP',fromJson: boolFromInt,toJson: boolToInt)
   bool? isPJP;

  WOutlet({
    required this.outletId,
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
    this.longitude,
    this.lattitude,
    this.routeName,
    this.visitTimeLat,
    this.visitTimeLng,
    this.surveyTaken,
    this.lastVisit,
    this.totalCoolers,
    this.isZeroSaleOutlet,
    this.alreadyVisit,
    this.mtdSale,
    this.isPJP,
  });

  factory WOutlet.fromJson(Map<String, dynamic> json) => _$WOutletFromJson(json);

  Map<String, dynamic> toJson() => _$WOutletToJson(this);
}

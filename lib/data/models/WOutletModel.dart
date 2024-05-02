import 'package:json_annotation/json_annotation.dart';

import '../../../../utils/Utils.dart';

part 'WOutletModel.g.dart';

@JsonSerializable()
class WOutletModel {
  @JsonKey(name: 'outletId')
  final int outletId;

  @JsonKey(name: 'routeId')
  final int? routeId;

  @JsonKey(name: 'outletCode')
  final String? outletCode;

  @JsonKey(name: 'outletName')
  final String? outletName;

  @JsonKey(name: 'outletChannel')
  final String? channelName;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'address')
  final String? address;

  @JsonKey(name: 'location')
  final String? location;

  @JsonKey(name: 'distributionId')
  final int? distributionId;

  @JsonKey(name: 'distributionName')
  final String? distributionName;

  @JsonKey(name: 'longitude')
  final double? longitude;

  @JsonKey(name: 'lattitude')
  final double? lattitude;

  @JsonKey(name: 'routeName')
  final String? routeName;

  final double? visitTimeLat;
  final double? visitTimeLng;

  @JsonKey(name: 'surveyTaken',toJson: boolToInt)
  final bool? surveyTaken;

  @JsonKey(name: 'lastVisit')
  final String? lastVisit;

  @JsonKey(name: 'totalCoolers')
  final int? totalCoolers;

  @JsonKey(name: 'isZeroSaleOutlet',toJson: boolToInt)
  final bool? isZeroSaleOutlet;

  @JsonKey(name: 'wwLastVisitSameMonth',toJson: boolToInt)
  final bool? alreadyVisit;

  @JsonKey(name: 'mtdSale')
  final double? mtdSale;

  @JsonKey(name: 'isPJP',toJson: boolToInt)
  final bool? isPJP;

  WOutletModel({
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

  factory WOutletModel.fromJson(Map<String, dynamic> json) => _$WOutletModelFromJson(json);

  Map<String, dynamic> toJson() => _$WOutletModelToJson(this);
}

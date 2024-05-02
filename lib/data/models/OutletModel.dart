import 'package:json_annotation/json_annotation.dart';

import '../../../utils/Utils.dart';

part 'OutletModel.g.dart';

@JsonSerializable()
class OutletModel {
  @JsonKey(name: 'outletId')
  final int? outletId;

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

  @JsonKey(name: 'lattitude')
  final double? lattitude;

  @JsonKey(name: 'longitude')
  final double? longitude;

  @JsonKey(name: 'totalCoolers')
  final int? totalCoolers;

  @JsonKey(name: 'routeName')
  final String? routeName;

  @JsonKey(name: 'lastVisit')
  final String? lastVisit;

  @JsonKey(name: 'isZeroSaleOutlet',toJson: boolToInt)
  final bool? isZeroSaleOutlet;

  @JsonKey(name: 'isPJP',toJson: boolToInt)
  final bool? isPJP;

  @JsonKey(name: 'mvLastVisitSameMonth',toJson: boolToInt)
  final bool? alreadyVisit;

  @JsonKey(name: 'mtdSale')
  final double? mtdSale;

  @JsonKey(name: 'visitTimeLat')
  final double? visitTimeLat;

  @JsonKey(name: 'visitTimeLng')
  final double? visitTimeLng;

  @JsonKey(name: 'synced',toJson: boolToInt)
  final bool? synced;

  @JsonKey(name: 'surveyTaken',toJson: boolToInt)
  final bool? surveyTaken;

  OutletModel(
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

  factory OutletModel.fromJson(Map<String, dynamic> json) => _$OutletModelFromJson(json);

  Map<String, dynamic> toJson() => _$OutletModelToJson(this);
}

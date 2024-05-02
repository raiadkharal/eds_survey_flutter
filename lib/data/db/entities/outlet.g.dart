// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outlet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Outlet _$OutletFromJson(Map<String, dynamic> json) => Outlet(
      json['outletId'] as int?,
      json['routeId'] as int?,
      json['outletCode'] as String?,
      json['outletName'] as String?,
      json['outletChannel'] as String?,
      json['status'] as int?,
      json['city'] as String?,
      json['address'] as String?,
      json['location'] as String?,
      json['distributionId'] as int?,
      json['distributionName'] as String?,
      (json['lattitude'] as num?)?.toDouble(),
      (json['longitude'] as num?)?.toDouble(),
      json['totalCoolers'] as int?,
      json['routeName'] as String?,
      json['lastVisit'] as String?,
      boolFromInt(json['isZeroSaleOutlet'] as int?),
      boolFromInt(json['isPJP'] as int?),
      boolFromInt(json['mvLastVisitSameMonth'] as int?),
      (json['mtdSale'] as num?)?.toDouble(),
      (json['visitTimeLat'] as num?)?.toDouble(),
      (json['visitTimeLng'] as num?)?.toDouble(),
      boolFromInt(json['synced'] as int?),
      boolFromInt(json['surveyTaken'] as int?),
    );

Map<String, dynamic> _$OutletToJson(Outlet instance) => <String, dynamic>{
      'outletId': instance.outletId,
      'routeId': instance.routeId,
      'outletCode': instance.outletCode,
      'outletName': instance.outletName,
      'outletChannel': instance.channelName,
      'status': instance.status,
      'city': instance.city,
      'address': instance.address,
      'location': instance.location,
      'distributionId': instance.distributionId,
      'distributionName': instance.distributionName,
      'lattitude': instance.lattitude,
      'longitude': instance.longitude,
      'totalCoolers': instance.totalCoolers,
      'routeName': instance.routeName,
      'lastVisit': instance.lastVisit,
      'isZeroSaleOutlet': boolToInt(instance.isZeroSaleOutlet),
      'isPJP': boolToInt(instance.isPJP),
      'mvLastVisitSameMonth': boolToInt(instance.alreadyVisit),
      'mtdSale': instance.mtdSale,
      'visitTimeLat': instance.visitTimeLat,
      'visitTimeLng': instance.visitTimeLng,
      'synced': boolToInt(instance.synced),
      'surveyTaken': boolToInt(instance.surveyTaken),
    };

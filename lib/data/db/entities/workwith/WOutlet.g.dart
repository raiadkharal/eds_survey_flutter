// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WOutlet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WOutlet _$WOutletFromJson(Map<String, dynamic> json) => WOutlet(
      outletId: json['outletId'] as int,
      routeId: json['routeId'] as int?,
      outletCode: json['outletCode'] as String?,
      outletName: json['outletName'] as String?,
      channelName: json['outletChannel'] as String?,
      status: json['status'] as int?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      location: json['location'] as String?,
      distributionId: json['distributionId'] as int?,
      distributionName: json['distributionName'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      lattitude: (json['lattitude'] as num?)?.toDouble(),
      routeName: json['routeName'] as String?,
      visitTimeLat: (json['visitTimeLat'] as num?)?.toDouble(),
      visitTimeLng: (json['visitTimeLng'] as num?)?.toDouble(),
      surveyTaken: boolFromInt(json['surveyTaken'] as int?),
      lastVisit: json['lastVisit'] as String?,
      totalCoolers: json['totalCoolers'] as int?,
      isZeroSaleOutlet: boolFromInt(json['isZeroSaleOutlet'] as int?),
      alreadyVisit: boolFromInt(json['wwLastVisitSameMonth'] as int?),
      mtdSale: (json['mtdSale'] as num?)?.toDouble(),
      isPJP: boolFromInt(json['isPJP'] as int?),
    );

Map<String, dynamic> _$WOutletToJson(WOutlet instance) => <String, dynamic>{
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
      'longitude': instance.longitude,
      'lattitude': instance.lattitude,
      'routeName': instance.routeName,
      'visitTimeLat': instance.visitTimeLat,
      'visitTimeLng': instance.visitTimeLng,
      'surveyTaken': boolToInt(instance.surveyTaken),
      'lastVisit': instance.lastVisit,
      'totalCoolers': instance.totalCoolers,
      'isZeroSaleOutlet': boolToInt(instance.isZeroSaleOutlet),
      'wwLastVisitSameMonth': boolToInt(instance.alreadyVisit),
      'mtdSale': instance.mtdSale,
      'isPJP': boolToInt(instance.isPJP),
    };

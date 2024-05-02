// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WOutletModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WOutletModel _$WOutletModelFromJson(Map<String, dynamic> json) => WOutletModel(
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
      surveyTaken: json['surveyTaken'] as bool?,
      lastVisit: json['lastVisit'] as String?,
      totalCoolers: json['totalCoolers'] as int?,
      isZeroSaleOutlet: json['isZeroSaleOutlet'] as bool?,
      alreadyVisit: json['wwLastVisitSameMonth'] as bool?,
      mtdSale: (json['mtdSale'] as num?)?.toDouble(),
      isPJP: json['isPJP'] as bool?,
    );

Map<String, dynamic> _$WOutletModelToJson(WOutletModel instance) =>
    <String, dynamic>{
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FormOneModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormOneSingletonModel _$FormOneSingletonModelFromJson(Map<String, dynamic> json) {
  return FormOneSingletonModel.getInstance()
    ..outletReqId = json['outletReqId'] as int?
    ..outletId = json['outletId'] as int?
    ..outletCode = json['outletCode'] as String?
    ..outletName = json['outletName'] as String?
    ..outletAddress = json['outletAddress'] as String?
    ..landmark = json['landmark'] as String?
    ..radius = (json['radius'] as num?)?.toDouble()
    ..vpoClassification = json['vpoClassification'] as String?
    ..vpoClassificationId = json['vpoClassificationId'] as int?
    ..lat = (json['lat'] as num?)?.toDouble()
    ..lng = (json['lng'] as num?)?.toDouble()
    ..cityId = json['cityId'] as int?
    ..routeId = json['routeId'] as int?
    ..organizationId = json['organizationId'] as int?
    ..distributionId = json['distributionId'] as int?
    ..competitorsCooler = json['competitorsCooler'] as bool?
    ..journeyPlan = json['journeyPlan'] as bool?
    ..marketTypeId = json['marketTypeId'] as int?
    ..tradeClassificationId = json['tradeClassificationId'] as int?
    ..outletClassificationId = json['outletClassificationId'] as int?
    ..channelId = json['channelId'] as int?
    ..agreedSalesVolume = json['agreedSalesVolume'] as int?
    ..comments = json['comments'] as String?
    ..marketType = json['marketType'] as String?
    ..city = json['city'] as String?
    ..routes = json['routes'] as String?
    ..outletType = json['outletType'] as String?
    ..tradeClassification = json['tradeClassification'] as String?
    ..outletClassification = json['outletClassification'] as String?
    ..channelType = json['channelType'] as String?
    ..pjpModels = (json['pjpModels'] as List<dynamic>?)
        ?.map((e) => PJPModel.fromJson(e as Map<String, dynamic>))
        .toList()
    ..requestId = json['requestId'] as int?
    ..requestTypeId = json['requestTypeId'] as int?
    ..requestFormId = json['requestFormId'] as int?
    ..workFlowId = json['workFlowId'] as int?
    ..outletTypeId = json['outletTypeId'] as int?;
}

Map<String, dynamic> _$FormOneSingletonModelToJson(FormOneSingletonModel instance) =>
    <String, dynamic>{
      'outletReqId': instance.outletReqId,
      'outletId': instance.outletId,
      'outletCode': instance.outletCode,
      'outletName': instance.outletName,
      'outletAddress': instance.outletAddress,
      'landmark': instance.landmark,
      'radius': instance.radius,
      'vpoClassification': instance.vpoClassification,
      'vpoClassificationId': instance.vpoClassificationId,
      'lat': instance.lat,
      'lng': instance.lng,
      'cityId': instance.cityId,
      'routeId': instance.routeId,
      'organizationId': instance.organizationId,
      'distributionId': instance.distributionId,
      'competitorsCooler': instance.competitorsCooler,
      'journeyPlan': instance.journeyPlan,
      'marketTypeId': instance.marketTypeId,
      'tradeClassificationId': instance.tradeClassificationId,
      'outletClassificationId': instance.outletClassificationId,
      'channelId': instance.channelId,
      'agreedSalesVolume': instance.agreedSalesVolume,
      'comments': instance.comments,
      'marketType': instance.marketType,
      'city': instance.city,
      'routes': instance.routes,
      'outletType': instance.outletType,
      'tradeClassification': instance.tradeClassification,
      'outletClassification': instance.outletClassification,
      'channelType': instance.channelType,
      'pjpModels': instance.pjpModels,
      'requestId': instance.requestId,
      'requestTypeId': instance.requestTypeId,
      'requestFormId': instance.requestFormId,
      'workFlowId': instance.workFlowId,
      'outletTypeId': instance.outletTypeId,
    };

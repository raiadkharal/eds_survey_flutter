// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SurveyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyModel _$SurveyModelFromJson(Map<String, dynamic> json) => SurveyModel()
  ..errorMessage = json['errorMessage'] as String?
  ..success = json['success'] as String?
  ..errorCode = json['errorCode'] as int?
  ..startDateTime = json['startDateTime'] as int?
  ..endDateTime = json['endDateTime'] as int?
  ..assets = (json['assets'] as List<dynamic>?)
      ?.map((e) => Asset.fromJson(e as Map<String, dynamic>))
      .toList()
  ..tasks = (json['tasks'] as List<dynamic>?)
      ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
      .toList()
  ..surveyWith = json['surveyWith'] as String?
  ..outletId = json['outletId'] as int?
  ..outletImages = (json['outletImages'] as List<dynamic>?)
      ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..marketVisitResponses = (json['marketVisitResponses'] as List<dynamic>?)
      ?.map((e) => MarketVisitResponse.fromJson(e as Map<String, dynamic>))
      .toList()
  ..merchandisingImages = (json['merchandisingImages'] as List<dynamic>?)
      ?.map((e) => MerchandisingImage.fromJson(e as Map<String, dynamic>))
      .toList()
  ..latitude = (json['latitude'] as num?)?.toDouble()
  ..longitude = (json['longitude'] as num?)?.toDouble()
  ..outletLatitude = (json['outletLatitude'] as num?)?.toDouble()
  ..outletLongitude = (json['outletLongitude'] as num?)?.toDouble()
  ..distance = (json['distance'] as num?)?.toDouble()
  ..outletRemarks = json['outletRemarks'] as String?
  ..feedBack = json['feedBack'] as String?
  ..customerSignature = json['customerSignature'] as String?
  ..statusId = json['statusId'] as int?;

Map<String, dynamic> _$SurveyModelToJson(SurveyModel instance) {
 Map<String, dynamic> data ={
    'errorMessage': instance.errorMessage,
    'success': instance.success,
    'errorCode': instance.errorCode,
    'startDateTime': instance.startDateTime,
    'endDateTime': instance.endDateTime,
    'assets': instance.assets,
    'tasks': instance.tasks,
    'surveyWith': instance.surveyWith,
    'outletId': instance.outletId,
    'outletImages': instance.outletImages,
    'marketVisitResponses': instance.marketVisitResponses,
    'merchandisingImages': instance.merchandisingImages,
    'latitude': instance.latitude,
    'longitude': instance.longitude,
    'outletLatitude': instance.outletLatitude,
    'outletLongitude': instance.outletLongitude,
    'distance': instance.distance,
    'outletRemarks': instance.outletRemarks,
    'feedBack': instance.feedBack,
    'customerSignature': instance.customerSignature,
    'statusId': instance.statusId,
  };

 data.removeWhere((key, value) => value==null);

 return data;
}

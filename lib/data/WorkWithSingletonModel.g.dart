// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkWithSingletonModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkWithSingletonModel _$WorkWithSingletonModelFromJson(
        Map<String, dynamic> json) =>
    WorkWithSingletonModel()
      ..date = json['date'] as int?
      ..psrCode = json['psrCode'] as String?
      ..routeId = json['routeId'] as int?
      ..userCode = json['userCode'] as String?
      ..outletId = json['outletId'] as int?
      ..distributionId = json['distributionId'] as int?
      ..statusId = json['statusId'] as int?
      ..remarks = json['remarks'] as String?
      ..feedback = json['feedback'] as String?
      ..barCodes =
          (json['barCodes'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..stcCount = (json['stcCount'] as num?)?.toDouble()
      ..esCount = (json['esCount'] as num?)?.toDouble()
      ..MAStrenght1 = json['MAStrenght1'] as int?
      ..MAStrenght2 = json['MAStrenght2'] as int?
      ..ESStrenght1 = json['ESStrenght1'] as int?
      ..ESStrenght2 = json['ESStrenght2'] as int?
      ..MAOpportunity1 = json['MAOpportunity1'] as String?
      ..MAOpportunity2 = json['MAOpportunity2'] as String?
      ..ESOpportunity1 = json['ESOpportunity1'] as String?
      ..ESOpportunity2 = json['ESOpportunity2'] as String?
      ..responses = (json['responses'] as List<dynamic>?)
          ?.map((e) => MarketVisitResponse.fromJson(e as Map<String, dynamic>))
          .toList()
      ..tasks = (json['tasks'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList()
      ..dailyVisitId = json['dailyVisitId'] as int?
      ..objective = json['objective'] as String?
      ..startDateTime = json['startDateTime'] as int?
      ..endDateTime = json['endDateTime'] as int?
      ..latitude = (json['latitude'] as num?)?.toDouble()
      ..longitude = (json['longitude'] as num?)?.toDouble()
      ..outletLatitude = (json['outletLatitude'] as num?)?.toDouble()
      ..outletLongitude = (json['outletLongitude'] as num?)?.toDouble()
      ..distance = (json['distance'] as num?)?.toDouble()
      ..status = json['status'] as int?
      ..psrId = json['psrId'] as int?
      ..questionsCode = (json['questionsCode'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..customerSignature = json['customerSignature'] as String?
      ..surveyorName = json['surveyorName'] as String?
      ..surveyorDesignation = json['surveyorDesignation'] as String?
      ..merchandisingImages = (json['merchandisingImages'] as List<dynamic>?)
          ?.map((e) => MerchandisingImage.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WorkWithSingletonModelToJson(
    WorkWithSingletonModel instance) {
  Map<String, dynamic> data = {
    'date': instance.date,
    'psrCode': instance.psrCode,
    'routeId': instance.routeId,
    'userCode': instance.userCode,
    'outletId': instance.outletId,
    'distributionId': instance.distributionId,
    'statusId': instance.statusId,
    'remarks': instance.remarks,
    'feedback': instance.feedback,
    'barCodes': instance.barCodes,
    'stcCount': instance.stcCount,
    'esCount': instance.esCount,
    'MAStrenght1': instance.MAStrenght1,
    'MAStrenght2': instance.MAStrenght2,
    'ESStrenght1': instance.ESStrenght1,
    'ESStrenght2': instance.ESStrenght2,
    'MAOpportunity1': instance.MAOpportunity1,
    'MAOpportunity2': instance.MAOpportunity2,
    'ESOpportunity1': instance.ESOpportunity1,
    'ESOpportunity2': instance.ESOpportunity2,
    'responses': instance.responses,
    'tasks': instance.tasks,
    'dailyVisitId': instance.dailyVisitId,
    'objective': instance.objective,
    'startDateTime': instance.startDateTime,
    'endDateTime': instance.endDateTime,
    'latitude': instance.latitude,
    'longitude': instance.longitude,
    'outletLatitude': instance.outletLatitude,
    'outletLongitude': instance.outletLongitude,
    'distance': instance.distance,
    'status': instance.status,
    'psrId': instance.psrId,
    'questionsCode': instance.questionsCode,
    'customerSignature': instance.customerSignature,
    'surveyorName': instance.surveyorName,
    'surveyorDesignation': instance.surveyorDesignation,
    'merchandisingImages': instance.merchandisingImages,
  };
  //exclude all the fields the with null values
  data.removeWhere((key, value) => value == null);
  return data;
}

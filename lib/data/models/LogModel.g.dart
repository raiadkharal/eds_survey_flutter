// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LogModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogModel _$LogModelFromJson(Map<String, dynamic> json) => LogModel()
  ..errorMessage = json['errorMessage'] as String?
  ..success = json['success'] as String?
  ..errorCode = json['errorCode'] as int?
  ..distributionId = json['distributionId'] as int?
  ..operationTypeId = json['operationTypeId'] as int?
  ..salesmanId = json['salesmanId'] as int?
  ..startDay = json['startDay'] as int?;

Map<String, dynamic> _$LogModelToJson(LogModel instance) => <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'distributionId': instance.distributionId,
      'operationTypeId': instance.operationTypeId,
      'salesmanId': instance.salesmanId,
      'startDay': instance.startDay,
    };

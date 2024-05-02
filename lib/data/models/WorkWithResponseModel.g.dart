// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkWithResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkWithResponseModel _$WorkWithResponseModelFromJson(
        Map<String, dynamic> json) =>
    WorkWithResponseModel()
      ..errorMessage = json['errorMessage'] as String?
      ..success = json['success'] as String?
      ..errorCode = json['errorCode'] as int?
      ..targetOutlets = json['targetOutlets'] as int?
      ..outlets = (json['outlets'] as List<dynamic>?)
          ?.map((e) => WOutletModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..routes = (json['routes'] as List<dynamic>?)
          ?.map((e) => WRoute.fromJson(e as Map<String, dynamic>))
          .toList()
      ..distributions = (json['distributions'] as List<dynamic>?)
          ?.map((e) => WDistribution.fromJson(e as Map<String, dynamic>))
          .toList()
      ..tasks = (json['tasks'] as List<dynamic>?)
          ?.map((e) => WTask.fromJson(e as Map<String, dynamic>))
          .toList()
      ..taskTypes = (json['taskTypes'] as List<dynamic>?)
          ?.map((e) => WTaskType.fromJson(e as Map<String, dynamic>))
          .toList()
      ..psrs = (json['psr'] as List<dynamic>?)
          ?.map((e) => Psr.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WorkWithResponseModelToJson(
        WorkWithResponseModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'targetOutlets': instance.targetOutlets,
      'outlets': instance.outlets,
      'routes': instance.routes,
      'distributions': instance.distributions,
      'tasks': instance.tasks,
      'taskTypes': instance.taskTypes,
      'psr': instance.psrs,
    };

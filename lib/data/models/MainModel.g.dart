// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MainModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainModel _$MainModelFromJson(Map<String, dynamic> json) => MainModel()
  ..errorMessage = json['errorMessage'] as String?
  ..success = json['success'] as String?
  ..errorCode = json['errorCode'] as int?
  ..targetOutlets = json['targetOutlets'] as int?
  ..outlets = (json['outlets'] as List<dynamic>?)
      ?.map((e) => OutletModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..routes = (json['routes'] as List<dynamic>?)
      ?.map((e) => MRoute.fromJson(e as Map<String, dynamic>))
      .toList()
  ..distributions = (json['distributions'] as List<dynamic>?)
      ?.map((e) => Distribution.fromJson(e as Map<String, dynamic>))
      .toList()
  ..designations = (json['designations'] as List<dynamic>?)
      ?.map((e) => Designation.fromJson(e as Map<String, dynamic>))
      .toList()
  ..tasks = (json['tasks'] as List<dynamic>?)
      ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
      .toList()
  ..packMappings = (json['packMappings'] as List<dynamic>?)
      ?.map((e) => PackMapping.fromJson(e as Map<String, dynamic>))
      .toList()
  ..taskTypes = (json['taskTypes'] as List<dynamic>?)
      ?.map((e) => TaskType.fromJson(e as Map<String, dynamic>))
      .toList()
  ..missingReasons = (json['assetMissingReasons'] as List<dynamic>?)
      ?.map((e) => AssetMissingReason.fromJson(e as Map<String, dynamic>))
      .toList()
  ..outletAssets = (json['outletAssets'] as List<dynamic>?)
      ?.map((e) => AssetEntity.fromJson(e as Map<String, dynamic>))
      .toList()
  ..packages = (json['packages'] as List<dynamic>?)
      ?.map((e) => LookUpObject.fromJson(e as Map<String, dynamic>))
      .toList()
  ..brands = (json['brands'] as List<dynamic>?)
      ?.map((e) => LookUpObject.fromJson(e as Map<String, dynamic>))
      .toList()
  ..configuration = json['configuration'] == null
      ? null
      : Configuration.fromJson(json['configuration'] as Map<String, dynamic>)
  ..products = (json['products'] as List<dynamic>?)
      ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MainModelToJson(MainModel instance) => <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'targetOutlets': instance.targetOutlets,
      'outlets': instance.outlets,
      'routes': instance.routes,
      'distributions': instance.distributions,
      'designations': instance.designations,
      'tasks': instance.tasks,
      'packMappings': instance.packMappings,
      'taskTypes': instance.taskTypes,
      'assetMissingReasons': instance.missingReasons,
      'outletAssets': instance.outletAssets,
      'packages': instance.packages,
      'brands': instance.brands,
      'configuration': instance.configuration,
      'products': instance.products,
    };

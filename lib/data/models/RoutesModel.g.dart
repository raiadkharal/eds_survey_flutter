// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RoutesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutesModel _$RoutesModelFromJson(Map<String, dynamic> json) => RoutesModel()
  ..errorMessage = json['errorMessage'] as String?
  ..success = json['success'] as String?
  ..errorCode = json['errorCode'] as int?
  ..outlets =(json['outlets'] as List<dynamic>)
      .map((e) => OutletTable.fromJson(e as Map<String, dynamic>))
      .toList()
  ..documents = (json['documents'] as List<dynamic>)
      .map((e) => DocumentTable.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$RoutesModelToJson(RoutesModel instance) =>
    <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'success': instance.success,
      'errorCode': instance.errorCode,
      'outlets': instance.outlets,
      'documents': instance.documents
    };

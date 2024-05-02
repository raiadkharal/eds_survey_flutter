// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UploadProgressModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadProgressModel _$UploadProgressModelFromJson(Map<String, dynamic> json) {
  return UploadProgressModel(
    uploadType: json['uploadType'] as String?,
    description: json['description'] as String?,
    marketVisit: json['marketVisit'] == null
        ? null
        : MarketVisit.fromJson(json['marketVisit'] as Map<String, dynamic>),
    workWithPre: json['workWithPre'] == null
        ? null
        : WorkWithPre.fromJson(json['workWithPre'] as Map<String, dynamic>),
    workWithPost: json['workWithPost'] == null
        ? null
        : WorkWithPost.fromJson(json['workWithPost'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UploadProgressModelToJson(
    UploadProgressModel instance) =>
    <String, dynamic>{
      'uploadType': instance.uploadType,
      'description': instance.description,
      'marketVisit': instance.marketVisit?.toJson(),
      'workWithPre': instance.workWithPre?.toJson(),
      'workWithPost': instance.workWithPost?.toJson(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetEntity _$AssetEntityFromJson(Map<String, dynamic> json) => AssetEntity(
      json['assetId'] as int,
      json['outletId'] as int?,
      json['assetNumber'] as String?,
      json['assetType'] as String?,
      json['status'] as String?,
      json['serialNumber'] as String?,
    );

Map<String, dynamic> _$AssetEntityToJson(AssetEntity instance) =>
    <String, dynamic>{
      'assetId': instance.assetId,
      'outletId': instance.outletId,
      'assetNumber': instance.assetNumber,
      'assetType': instance.assetType,
      'status': instance.status,
      'serialNumber': instance.serialNumber,
    };

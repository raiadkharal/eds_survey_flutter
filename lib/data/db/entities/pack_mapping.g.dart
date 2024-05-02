// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack_mapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackMapping _$PackMappingFromJson(Map<String, dynamic> json) => PackMapping(
      id: json['id'] as int,
      packId: json['packId'] as int?,
      packName: json['packName'] as String?,
      companyId: json['companyId'] as int?,
      companyName: json['companyName'] as String?,
      skuId: json['skuId'] as String?,
      skuName: json['skuName'] as String?,
      isCold: json['isCold'] as bool?,
      isWarm: json['isWarm'] as bool?,
      isLowStock: json['isLowStock'] as bool?,
    );

Map<String, dynamic> _$PackMappingToJson(PackMapping instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packId': instance.packId,
      'packName': instance.packName,
      'companyId': instance.companyId,
      'companyName': instance.companyName,
      'skuId': instance.skuId,
      'skuName': instance.skuName,
      'isCold': boolToInt(instance.isCold),
      'isWarm': boolToInt(instance.isWarm),
      'isLowStock': instance.isLowStock,
    };

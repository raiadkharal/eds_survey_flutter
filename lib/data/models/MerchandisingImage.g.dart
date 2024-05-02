// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MerchandisingImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchandisingImage _$MerchandisingImageFromJson(Map<String, dynamic> json) =>
    MerchandisingImage(
      id: json['id'] as int?,
      path: json['path'] as String?,
      image: json['image'] as String?,
      type: json['type'] as int?,
    );

Map<String, dynamic> _$MerchandisingImageToJson(MerchandisingImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'image': instance.image,
      'type': instance.type,
    };

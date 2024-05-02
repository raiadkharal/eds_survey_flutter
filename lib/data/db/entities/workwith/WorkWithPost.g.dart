// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkWithPost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkWithPost _$WorkWithPostFromJson(Map<String, dynamic> json) => WorkWithPost(
      outletId: json['outletId'] as int,
      synced: boolFromInt(json['synced'] as int?),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$WorkWithPostToJson(WorkWithPost instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'synced': boolToInt(instance.synced),
      'data': instance.data,
    };

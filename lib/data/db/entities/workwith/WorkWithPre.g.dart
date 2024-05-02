// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkWithPre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkWithPre _$WorkWithPreFromJson(Map<String, dynamic> json) => WorkWithPre(
      routeId: json['routeId'] as int,
      psrId: json['psrId'] as int,
      outletId: json['outletId'] as int?,
      synced: boolFromInt(json['synced'] as int?),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$WorkWithPreToJson(WorkWithPre instance) =>
    <String, dynamic>{
      'routeId': instance.routeId,
      'psrId': instance.psrId,
      'outletId': instance.outletId,
      'synced': boolToInt(instance.synced),
      'data': instance.data,
    };

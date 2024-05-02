// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketVisit _$MarketVisitFromJson(Map<String, dynamic> json) => MarketVisit(
      json['outletId'] as int,
      boolFromInt(json['synced'] as int?),
      json['data'] as String?,
    );

Map<String, dynamic> _$MarketVisitToJson(MarketVisit instance) =>
    <String, dynamic>{
      'outletId': instance.outletId,
      'synced': boolToInt(instance.synced),
      'data': instance.data,
    };

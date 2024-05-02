// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MRoute _$MRouteFromJson(Map<String, dynamic> json) => MRoute(
      routeId: json['routeId'] as int?,
      routeName: json['routeName'] as String?,
      distributionId: json['distributionId'] as int?,
    );

Map<String, dynamic> _$MRouteToJson(MRoute instance) => <String, dynamic>{
      'routeId': instance.routeId,
      'routeName': instance.routeName,
      'distributionId': instance.distributionId,
    };

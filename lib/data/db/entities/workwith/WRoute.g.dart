// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WRoute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WRoute _$WRouteFromJson(Map<String, dynamic> json) => WRoute(
      mRouteId: json['routeId'] as int,
      mPsrId: json['psrId'] as int?,
      mRouteName: json['routeName'] as String?,
      distributionId: json['distributionId'] as int?,
    );

Map<String, dynamic> _$WRouteToJson(WRoute instance) => <String, dynamic>{
      'routeId': instance.mRouteId,
      'psrId': instance.mPsrId,
      'routeName': instance.mRouteName,
      'distributionId': instance.distributionId,
    };

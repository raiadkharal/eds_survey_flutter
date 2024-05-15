// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MarketVisitResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketVisitResponse _$MarketVisitResponseFromJson(Map<String, dynamic> json) =>
    MarketVisitResponse(
      json['type'] as String,
      json['questionCode'] as String,
      json['response'] as String,
    );

Map<String, dynamic> _$MarketVisitResponseToJson(
        MarketVisitResponse instance) =>
    <String, dynamic>{
      'questionCode': instance.questionCode,
      'response': instance.response,
      'type': instance.type,
    };

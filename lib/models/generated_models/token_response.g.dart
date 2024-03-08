// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../TokenResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse()
      ..accessToken = json['access_token'] as String?
      ..expiresIn = json['expires_in'] as int?
      ..tokenType = json['token_type'] as String?;

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiresIn': instance.expiresIn,
      'tokenType': instance.tokenType,
    };

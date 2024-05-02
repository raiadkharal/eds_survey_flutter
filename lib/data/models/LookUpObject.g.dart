// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LookUpObject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUpObject _$LookUpObjectFromJson(Map<String, dynamic> json) => LookUpObject(
      key: json['key'] as int?,
      value: json['value'] as String?,
      description: json['description'],
      firstIntExtraField: json['firstIntExtraField'] as int?,
      firstStringExtraField: json['firstStringExtraField'],
      defaultFlag: json['defaultFlag'] as bool?,
      secondIntExtraField: json['secondIntExtraField'] as int?,
      secondStringExtraField: json['secondStringExtraField'],
      hasError: json['hasError'] as bool?,
      errorMessage: json['errorMessage'],
    );

Map<String, dynamic> _$LookUpObjectToJson(LookUpObject instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
      'description': instance.description,
      'firstIntExtraField': instance.firstIntExtraField,
      'firstStringExtraField': instance.firstStringExtraField,
      'defaultFlag': instance.defaultFlag,
      'secondIntExtraField': instance.secondIntExtraField,
      'secondStringExtraField': instance.secondStringExtraField,
      'hasError': instance.hasError,
      'errorMessage': instance.errorMessage,
    };

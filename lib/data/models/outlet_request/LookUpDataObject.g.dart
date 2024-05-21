// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LookUpDataObject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LookUpDataObject _$LookUpDataObjectFromJson(Map<String, dynamic> json) {
  return LookUpDataObject(
    key: json['key'] as int?,
    value: json['value'] as String?,
    description: json['description'],
    firstIntExtraField: json['firstIntExtraField'] as int?,
    firstStringExtraField: json['firstStringExtraField'],
    defaultFlag: json['defaultFlag'] as bool?,
    secondIntExtraField: json['secondIntExtraField'] as int?,
    secondStringExtraField: json['secondStringExtraField'],
    hasError: json['hasError'] as bool?,
    minValue: json['minValue'] as int?,
    maxValue: json['maxValue'] as int?,
    quantity: json['quantity'] as int?,
    errorMessage: json['errorMessage'],
  );
}

Map<String, dynamic> _$LookUpDataObjectToJson(LookUpDataObject instance) =>
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
      'minValue': instance.minValue,
      'maxValue': instance.maxValue,
      'quantity': instance.quantity,
      'errorMessage': instance.errorMessage,
    };

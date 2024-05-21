import 'package:eds_survey/utils/Utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LookUpDataObject.g.dart';

@JsonSerializable()
class LookUpDataObject {
  @JsonKey(name: 'key')
  final int? key;

  @JsonKey(name: 'value')
  final String? value;

  @JsonKey(name: 'description')
  final dynamic description;

  @JsonKey(name: 'firstIntExtraField')
  final int? firstIntExtraField;

  @JsonKey(name: 'firstStringExtraField')
  final dynamic firstStringExtraField;

  @JsonKey(name: 'defaultFlag',fromJson: boolFromInt,toJson: boolToInt)
  final bool? defaultFlag;

  @JsonKey(name: 'secondIntExtraField')
  final int? secondIntExtraField;

  @JsonKey(name: 'secondStringExtraField')
  final dynamic secondStringExtraField;

  @JsonKey(name: 'hasError',fromJson: boolFromInt,toJson: boolToInt)
  final bool? hasError;

  @JsonKey(name: 'minValue')
  final int? minValue;

  @JsonKey(name: 'maxValue')
  final int? maxValue;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'errorMessage')
  final dynamic errorMessage;

  LookUpDataObject({
    this.key,
    this.value,
    this.description,
    this.firstIntExtraField,
    this.firstStringExtraField,
    this.defaultFlag,
    this.secondIntExtraField,
    this.secondStringExtraField,
    this.hasError,
    this.minValue,
    this.maxValue,
    this.quantity,
    this.errorMessage,
  });

  factory LookUpDataObject.fromJson(Map<String, dynamic> json) =>
      _$LookUpDataObjectFromJson(json);

  Map<String, dynamic> toJson() => _$LookUpDataObjectToJson(this);
}

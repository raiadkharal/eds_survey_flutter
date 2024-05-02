import 'package:json_annotation/json_annotation.dart';

part 'LookUpObject.g.dart';

@JsonSerializable()
class LookUpObject {
  @JsonKey(name: 'key')
  final int? key;

  @JsonKey(name: 'value')
  final String? value;

  @JsonKey(name: 'description')
  final Object? description;

  @JsonKey(name: 'firstIntExtraField')
  final int? firstIntExtraField;

  @JsonKey(name: 'firstStringExtraField')
  final Object? firstStringExtraField;

  @JsonKey(name: 'defaultFlag')
  final bool? defaultFlag;

  @JsonKey(name: 'secondIntExtraField')
  final int? secondIntExtraField;

  @JsonKey(name: 'secondStringExtraField')
  final Object? secondStringExtraField;

  @JsonKey(name: 'hasError')
  final bool? hasError;

  @JsonKey(name: 'errorMessage')
  final Object? errorMessage;

  LookUpObject({
    this.key,
    this.value,
    this.description,
    this.firstIntExtraField,
    this.firstStringExtraField,
    this.defaultFlag,
    this.secondIntExtraField,
    this.secondStringExtraField,
    this.hasError,
    this.errorMessage,
  });

  factory LookUpObject.fromJson(Map<String, dynamic> json) =>
      _$LookUpObjectFromJson(json);

  Map<String, dynamic> toJson() => _$LookUpObjectToJson(this);
}

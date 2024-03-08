import 'dart:async';

import 'package:json_annotation/json_annotation.dart';

part 'generated_models/base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'success')
  String? _success;
  @JsonKey(name: 'errorMessage')
  String? errorMessage;
  @JsonKey(name: 'errorCode')
  int? _errorCode;

  BaseResponse([this._success]);

  BaseResponse.withDetails(this._success, this.errorMessage, this._errorCode);

  String get success => _success == null ? "true" : _success!;

  set success(String value) {
    _success = value;
  }

  int? get errorCode => _errorCode == null ? 1 : _errorCode!;

  set errorCode(int? value) {
    _errorCode = value;
  }

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

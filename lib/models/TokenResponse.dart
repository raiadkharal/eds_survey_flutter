import 'package:json_annotation/json_annotation.dart';

part 'generated_models/token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  @JsonKey(name: 'access_token')
  String? _accessToken;

  @JsonKey(name: 'expires_in')
  int? _expiresIn;

  @JsonKey(name: 'token_type')
  String? _tokenType;

  @JsonKey(name: 'success')
  bool? _success = false;

  @JsonKey(name: 'error_description')
  String? _errorMessage;

  TokenResponse();

  String? get accessToken => _accessToken;

  set accessToken(String? value) {
    _accessToken = value;
  }

  int? get expiresIn => _expiresIn;

  set expiresIn(int? value) {
    _expiresIn = value;
  }

  String? get tokenType => _tokenType;

  set tokenType(String? value) {
    _tokenType = value;
  }

  bool get isSuccess => _success ?? false;

  String? get errorMessage => _errorMessage;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'Psr.g.dart';

@JsonSerializable()
class Psr {
  @JsonKey(name: 'psrId')
  final int psrId;

  @JsonKey(name: 'psrName')
  final String? psrName;

  @JsonKey(name: 'psrCode')
  final String? psrCode;

  Psr({
    required this.psrId,
    this.psrName,
    this.psrCode,
  });

  factory Psr.fromJson(Map<String, dynamic> json) => _$PsrFromJson(json);

  Map<String, dynamic> toJson() => _$PsrToJson(this);
}

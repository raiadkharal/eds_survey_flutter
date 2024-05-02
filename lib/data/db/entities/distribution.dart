import 'package:json_annotation/json_annotation.dart';

part 'distribution.g.dart';

@JsonSerializable()
class Distribution {
  @JsonKey(name: 'distributionId')
  final int distributionId;

  @JsonKey(name: 'distributionName')
  final String? distributionName;

  Distribution(this.distributionId, this.distributionName);

  factory Distribution.fromJson(Map<String, dynamic> json) =>
      _$DistributionFromJson(json);

  Map<String, dynamic> toJson() => _$DistributionToJson(this);

}

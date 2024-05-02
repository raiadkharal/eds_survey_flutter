import 'package:json_annotation/json_annotation.dart';

part 'WDistribution.g.dart';

@JsonSerializable()
class WDistribution {
  @JsonKey(name: 'distributionId')
  final int distributionId;

  @JsonKey(name: 'distributionName')
  final String? distributionName;

  WDistribution({required this.distributionId, this.distributionName});

  factory WDistribution.fromJson(Map<String, dynamic> json) =>
      _$WDistributionFromJson(json);

  Map<String, dynamic> toJson() => _$WDistributionToJson(this);
}

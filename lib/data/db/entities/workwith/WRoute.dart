
import 'package:json_annotation/json_annotation.dart';

part 'WRoute.g.dart';

@JsonSerializable()
class WRoute {

  @JsonKey(name: 'routeId')
  final int mRouteId;

  @JsonKey(name: 'psrId')
  final int? mPsrId;

  @JsonKey(name: 'routeName')
  final String? mRouteName;

  @JsonKey(name: 'distributionId')
  final int? distributionId;

  WRoute({
    required this.mRouteId,
    this.mPsrId,
    this.mRouteName,
    this.distributionId,
  });

  factory WRoute.fromJson(Map<String, dynamic> json) => _$WRouteFromJson(json);

  Map<String, dynamic> toJson() => _$WRouteToJson(this);
}

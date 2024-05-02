import 'package:json_annotation/json_annotation.dart';

part 'route.g.dart';

@JsonSerializable()
class MRoute {
  @JsonKey(name: 'routeId')
  final int? routeId;

  @JsonKey(name: 'routeName')
  final String? routeName;

  @JsonKey(name: 'distributionId')
  final int? distributionId;

  MRoute({
    this.routeId,
    this.routeName,
    this.distributionId,
  });

  factory MRoute.fromJson(Map<String, dynamic> json) => _$MRouteFromJson(json);

  Map<String, dynamic> toJson() => _$MRouteToJson(this);

  @override
  String toString() {
    return routeName ?? ''; // What to display in the Spinner list.
  }
}

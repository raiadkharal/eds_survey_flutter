import 'package:json_annotation/json_annotation.dart';

part 'OutletTable.g.dart';

@JsonSerializable()
class OutletTable {
  @JsonKey(name: 'outlet_id')
  final int? outletId;

  final int? routeId;
  final String? routeName;
  final int? outletIdAlt;
  final String? outletCode;
  final String? outletName;
  final String? location;
  final String? address;
  final String? lastScaniningDate;
  final String? ownerFatherName;
  final String? contactPerson1;
  final String? contactPerson1CellNumber;
  final String? contactNumber;
  final String? cnic;
  final String? ownerName;
  final int? distributionId;
  final String? distributionName;
  final int? organizationId;
  final String? organizationName;
  final int? unitId;
  final String? unitName;
  final int? agreedYTDSalesVolume;
  final String? ytdSalesVolume;
  final double? longitude;
  final double? lattitude;

  OutletTable({
    this.outletId,
    this.routeId,
    this.routeName,
    this.outletIdAlt,
    this.outletCode,
    this.outletName,
    this.location,
    this.address,
    this.lastScaniningDate,
    this.ownerFatherName,
    this.contactPerson1,
    this.contactPerson1CellNumber,
    this.contactNumber,
    this.cnic,
    this.ownerName,
    this.distributionId,
    this.distributionName,
    this.organizationId,
    this.organizationName,
    this.unitId,
    this.unitName,
    this.agreedYTDSalesVolume,
    this.ytdSalesVolume,
    this.longitude,
    this.lattitude,
  });

  factory OutletTable.fromJson(Map<String, dynamic> json) => _$OutletTableFromJson(json);

  Map<String, dynamic> toJson() => _$OutletTableToJson(this);
}

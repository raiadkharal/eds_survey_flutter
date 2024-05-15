// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OutletTable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutletTable _$OutletTableFromJson(Map<String, dynamic> json) => OutletTable(
  outletId: json['outlet_id'] as int?,
  routeId: json['routeId'] as int?,
  routeName: json['routeName'] as String?,
  outletIdAlt: json['outletId'] as int?,
  outletCode: json['outletCode'] as String?,
  outletName: json['outletName'] as String?,
  location: json['location'] as String?,
  address: json['address'] as String?,
  lastScaniningDate: json['lastScaniningDate'] as String?,
  ownerFatherName: json['ownerFatherName'] as String?,
  contactPerson1: json['contactPerson1'] as String?,
  contactPerson1CellNumber: json['contactPerson1CellNumber'] as String?,
  contactNumber: json['contactNumber'] as String?,
  cnic: json['cnic'] as String?,
  ownerName: json['ownerName'] as String?,
  distributionId: json['distributionId'] as int?,
  distributionName: json['distributionName'] as String?,
  organizationId: json['organizationId'] as int?,
  organizationName: json['organizationName'] as String?,
  unitId: json['unitId'] as int?,
  unitName: json['unitName'] as String?,
  agreedYTDSalesVolume: json['agreedYTDSalesVolume'] as int?,
  ytdSalesVolume: json['ytdSalesVolume'] as String?,
  longitude: (json['longitude'] as num?)?.toDouble(),
  lattitude: (json['lattitude'] as num?)?.toDouble(),
);

Map<String, dynamic> _$OutletTableToJson(OutletTable instance) =>
    <String, dynamic>{
      'outlet_id': instance.outletId,
      'routeId': instance.routeId,
      'routeName': instance.routeName,
      'outletId': instance.outletIdAlt,
      'outletCode': instance.outletCode,
      'outletName': instance.outletName,
      'location': instance.location,
      'address': instance.address,
      'lastScaniningDate': instance.lastScaniningDate,
      'ownerFatherName': instance.ownerFatherName,
      'contactPerson1': instance.contactPerson1,
      'contactPerson1CellNumber': instance.contactPerson1CellNumber,
      'contactNumber': instance.contactNumber,
      'cnic': instance.cnic,
      'ownerName': instance.ownerName,
      'distributionId': instance.distributionId,
      'distributionName': instance.distributionName,
      'organizationId': instance.organizationId,
      'organizationName': instance.organizationName,
      'unitId': instance.unitId,
      'unitName': instance.unitName,
      'agreedYTDSalesVolume': instance.agreedYTDSalesVolume,
      'ytdSalesVolume': instance.ytdSalesVolume,
      'longitude': instance.longitude,
      'lattitude': instance.lattitude,
    };

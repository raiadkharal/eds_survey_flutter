// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset()
  ..isUseEasyPaisa = json['isUseEasyPaisa'] as bool?
  ..assetImages = (json['assetImages'] as List<dynamic>)
      .map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..barcodeImages = (json['barcodeImages'] as List<dynamic>)
      .map((e) => Image.fromJson(e as Map<String, dynamic>))
      .toList()
  ..isAvailable = json['isAvailable'] as bool?
  ..serialNumber = json['serialNumber'] as String?
  ..isBarCodeDamaged = json['isBarCodeDamaged'] as bool?
  ..assetId = json['assetId'] as int?
  ..missingReason = json['missingReason'] as int?
  ..isOutletNameCorrect = json['isOutletNameCorrect'] as bool?
  ..correctOutletName = json['correctOutletName'] as String?
  ..remarks = json['remarks'] as String?;

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'isUseEasyPaisa': instance.isUseEasyPaisa,
      'assetImages': instance.assetImages,
      'barcodeImages': instance.barcodeImages,
      'isAvailable': instance.isAvailable,
      'serialNumber': instance.serialNumber,
      'isBarCodeDamaged': instance.isBarCodeDamaged,
      'assetId': instance.assetId,
      'missingReason': instance.missingReason,
      'isOutletNameCorrect': instance.isOutletNameCorrect,
      'correctOutletName': instance.correctOutletName,
      'remarks': instance.remarks,
    };

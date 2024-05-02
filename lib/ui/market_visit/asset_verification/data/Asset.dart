import 'package:eds_survey/ui/market_visit/asset_verification/data/Image.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Asset.g.dart';

@JsonSerializable()
class Asset {
  bool? _isUseEasyPaisa;
  List<Image> _assetImages = [];
  List<Image> _barcodeImages = [];
  bool? _isAvailable;
  String? _serialNumber;
  bool? _isBarCodeDamaged;
  int? _assetId;
  int? _missingReason;
  bool? _isOutletNameCorrect;
  String? _correctOutletName;
  String? _remarks;

  Asset() {
    _assetImages = [];
    _barcodeImages = [];
  }

  bool? get isUseEasyPaisa => _isUseEasyPaisa;

  set isUseEasyPaisa(bool? value) {
    _isUseEasyPaisa = value;
  }

  List<Image> get assetImages => _assetImages;

  set assetImages(List<Image> value) {
    _assetImages = value;
  }

  List<Image> get barcodeImages => _barcodeImages;

  set barcodeImages(List<Image> value) {
    _barcodeImages = value;
  }

  bool? get isAvailable => _isAvailable;

  set isAvailable(bool? value) {
    _isAvailable = value;
  }

  String? get serialNumber => _serialNumber;

  set serialNumber(String? value) {
    _serialNumber = value;
  }

  bool? get isBarCodeDamaged => _isBarCodeDamaged;

  set isBarCodeDamaged(bool? value) {
    _isBarCodeDamaged = value;
  }

  int? get assetId => _assetId;

  set assetId(int? value) {
    _assetId = value;
  }

  int? get missingReason => _missingReason;

  set missingReason(int? value) {
    _missingReason = value;
  }

  bool? get isOutletNameCorrect => _isOutletNameCorrect;

  set isOutletNameCorrect(bool? value) {
    _isOutletNameCorrect = value;
  }

  String? get correctOutletName => _correctOutletName;

  set correctOutletName(String? value) {
    _correctOutletName = value;
  }

  String? get remarks => _remarks;

  set remarks(String? value) {
    _remarks = value;
  }

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);
}

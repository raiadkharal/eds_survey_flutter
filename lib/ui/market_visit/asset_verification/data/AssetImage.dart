class AssetImage {
  String? assetImage;
  int? assetId;

  AssetImage(this.assetId, this.assetImage);

  String? getAssetImage() {
    return assetImage;
  }

  int? getAssetId() {
    return assetId;
  }

  @override
  bool operator ==(Object? other) {
    if (other is AssetImage) {
      return other.assetId == assetId;
    }
    return false;
  }


}

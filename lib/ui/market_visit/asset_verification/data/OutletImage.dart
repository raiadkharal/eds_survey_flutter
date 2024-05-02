class OutletImage {
  String? path;
  String? outletImage;
  int? outletId;

  OutletImage(this.path, this.outletId, this.outletImage);

  String? getPath() {
    return path;
  }

  String? getOutletImage() {
    return outletImage;
  }

  void setOutletImage(String? outletImage) {
    this.outletImage = outletImage;
  }

  int? getOutletId() {
    return outletId;
  }

  void setOutletId(int? outletId) {
    this.outletId = outletId;
  }


  @override
  bool operator ==(Object other) {
    if (other is OutletImage) {
      return other.outletId == outletId;
    }
    return false;
  }

}

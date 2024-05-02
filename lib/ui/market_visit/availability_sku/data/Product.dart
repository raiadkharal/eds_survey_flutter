class Product {
  String skuFull;
  bool value;

  Product(this.skuFull, this.value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.skuFull.toLowerCase() == skuFull.toLowerCase();
  }

  @override
  int get hashCode => super.hashCode;
}

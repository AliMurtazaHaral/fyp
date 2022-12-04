class ShopedProductModel {
  String? productName;
  String? pickupPoint;
  String? deliveryPoint;
  String? riderName;
  String? status;
  String? productPrice;
  ShopedProductModel(
      {this.productName,
        this.pickupPoint,
        this.deliveryPoint,
        this.productPrice,
        this.riderName,
        this.status,});

  // receiving data from server
  factory ShopedProductModel.fromShopedProduct(map) {
    return ShopedProductModel(

      productName: map['productName'],
      pickupPoint: map['pickupPoint'],
      deliveryPoint: map['deliveryPoint'],
      productPrice: map['productPrice'],
      riderName: map['riderName'],
      status: map['status'],
    );
  }
  // sending data to our server
  Map<String, dynamic> toMapShopedProduct() {
    return {
      'productName': productName,
      'pickupPoint': pickupPoint,
      'deliveryPoint': deliveryPoint,
      'productPrice': productPrice,
      'status': status,
    };
  }
  Map<String, dynamic> toMapShopedProductOrderComplete() {
    return {
      'status': status,
    };
  }
  Map<String, dynamic> toMapShopedProductChangeRiderName() {
    return {
      'riderName': riderName,
    };
  }
}

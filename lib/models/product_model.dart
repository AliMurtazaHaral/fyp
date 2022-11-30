class ProductModel {
  String? productName;
  String? productImage;
  String? productDescription;
  String? productRating;
  String? productPrice;
  String? productQuantity;
  ProductModel(
      {this.productName,
        this.productImage,
        this.productDescription,
        this.productPrice,
        this.productQuantity,
        this.productRating,});

  // receiving data from server
  factory ProductModel.fromProduct(map) {
    return ProductModel(

      productName: map['productName'],
      productImage: map['productImage'],
      productDescription: map['productDescription'],
      productPrice: map['productPrice'],
      productQuantity: map['productQuantity'],
      productRating: map['productRating'],
    );
  }
  // sending data to our server
  Map<String, dynamic> toMapProduct() {
    return {
      'productName': productName,
      'productRating': productRating,
      'productQuantity': productQuantity,
      'productPrice': productPrice,
      'productDescription': productDescription,
      'productImage': productImage,
    };
  }

}

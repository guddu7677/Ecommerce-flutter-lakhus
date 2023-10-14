class GetCartModel {
  int? id;
  String? img;
  String? productTitle;
  String? productSize;
  String? productColor;
  String? productPrice;
  int? quantity;
  int? user;
  int? product;

  GetCartModel(
      {this.id,
      this.img,
      this.productTitle,
      this.productSize,
      this.productColor,
      this.productPrice,
      this.quantity,
      this.user,
      this.product});

  GetCartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    productTitle = json['product_title'];
    productSize = json['product_size'];
    productColor = json['product_color'];
    productPrice = json['product_price'];
    quantity = json['quantity'];
    user = json['user'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['product_title'] = this.productTitle;
    data['product_size'] = this.productSize;
    data['product_color'] = this.productColor;
    data['product_price'] = this.productPrice;
    data['quantity'] = this.quantity;
    data['user'] = this.user;
    data['product'] = this.product;
    return data;
  }
}

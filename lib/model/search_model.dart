class SearchModel {
  int? id;
  List<int>? category;
  List<int>? subcategory;
  List<int>? color;
  List<int>? size;
  List<int>? brand;
  List<int>? tag;
  String? title;
  int? price;
  String? newOld;
  bool? onSale;
  bool? slider;
  bool? trending;
  bool? latest;
  String? img;
  int? gst;
  double? totalPrice;

  SearchModel(
      {this.id,
      this.category,
      this.subcategory,
      this.color,
      this.size,
      this.brand,
      this.tag,
      this.title,
      this.price,
      this.newOld,
      this.onSale,
      this.slider,
      this.trending,
      this.latest,
      this.img,
      this.gst,
      this.totalPrice});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'].cast<int>();
    subcategory = json['subcategory'].cast<int>();
    color = json['color'].cast<int>();
    size = json['size'].cast<int>();
    brand = json['brand'].cast<int>();
    tag = json['tag'].cast<int>();
    title = json['title'];
    price = json['price'];
    newOld = json['new_old'];
    onSale = json['on_sale'];
    slider = json['slider'];
    trending = json['trending'];
    latest = json['latest'];
    img = json['img'];
    gst = json['gst'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['color'] = this.color;
    data['size'] = this.size;
    data['brand'] = this.brand;
    data['tag'] = this.tag;
    data['title'] = this.title;
    data['price'] = this.price;
    data['new_old'] = this.newOld;
    data['on_sale'] = this.onSale;
    data['slider'] = this.slider;
    data['trending'] = this.trending;
    data['latest'] = this.latest;
    data['img'] = this.img;
    data['gst'] = this.gst;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

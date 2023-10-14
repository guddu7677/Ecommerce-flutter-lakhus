class FilterDataModel {
  int? id;
  String? title;
  String? short;
  String? description;
  int? price;
  int? gst;
  int? totalPrice;
  int? quantity;
  String? img;
  String? newOld;
  bool? onSale;
  bool? slider;
  bool? trending;
  bool? latest;
  bool? bestDeal;
  String? createAt;
  String? updateAt;
  List<int>? category;
  List<int>? subcategory;
  List<int>? color;
  List<int>? size;
  List<int>? brand;
  List<int>? tag;

  FilterDataModel(
      {this.id,
      this.title,
      this.short,
      this.description,
      this.price,
      this.gst,
      this.totalPrice,
      this.quantity,
      this.img,
      this.newOld,
      this.onSale,
      this.slider,
      this.trending,
      this.latest,
      this.bestDeal,
      this.createAt,
      this.updateAt,
      this.category,
      this.subcategory,
      this.color,
      this.size,
      this.brand,
      this.tag});

  FilterDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    short = json['short'];
    description = json['description'];
    price = json['price'];
    gst = json['gst'];
    totalPrice = json['total_price'];
    quantity = json['quantity'];
    img = json['img'];
    newOld = json['new_old'];
    onSale = json['on_sale'];
    slider = json['slider'];
    trending = json['trending'];
    latest = json['latest'];
    bestDeal = json['best_deal'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
    category = json['category'].cast<int>();
    subcategory = json['subcategory'].cast<int>();
    color = json['color'].cast<int>();
    size = json['size'].cast<int>();
    brand = json['brand'].cast<int>();
    tag = json['tag'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short'] = this.short;
    data['description'] = this.description;
    data['price'] = this.price;
    data['gst'] = this.gst;
    data['total_price'] = this.totalPrice;
    data['quantity'] = this.quantity;
    data['img'] = this.img;
    data['new_old'] = this.newOld;
    data['on_sale'] = this.onSale;
    data['slider'] = this.slider;
    data['trending'] = this.trending;
    data['latest'] = this.latest;
    data['best_deal'] = this.bestDeal;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['color'] = this.color;
    data['size'] = this.size;
    data['brand'] = this.brand;
    data['tag'] = this.tag;
    return data;
  }
}

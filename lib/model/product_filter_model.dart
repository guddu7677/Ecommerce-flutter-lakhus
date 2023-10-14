class Product {
  int? id;
  int? category;
  int? subcategory;
  int? microcategory;
  int? color;
  int? size;
  int? brand;
  List<int>? tag;
  String? title;
  int? price;
  String? newOld;
  bool? onSale;
  bool? slider;
  bool? trending;
  bool? latest;
  String? img;

  Product({
    this.id,
    this.category,
    this.subcategory,
    this.microcategory,
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
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    subcategory = json['subcategory'];
    microcategory = json['microcategory'];
    color = json['color'];
    size = json['size'];
    brand = json['brand'];
    if (json['tag'] != null) {
      tag = List<int>.from(json['tag']);
    }
    title = json['title'];
    price = json['price'];
    newOld = json['new_old'];
    onSale = json['on_sale'];
    slider = json['slider'];
    trending = json['trending'];
    latest = json['latest'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category'] = category;
    data['subcategory'] = subcategory;
    data['microcategory'] = microcategory;
    data['color'] = color;
    data['size'] = size;
    data['brand'] = brand;
    if (tag != null) {
      data['tag'] = tag;
    }
    data['title'] = title;
    data['price'] = price;
    data['new_old'] = newOld;
    data['on_sale'] = onSale;
    data['slider'] = slider;
    data['trending'] = trending;
    data['latest'] = latest;
    data['img'] = img;
    return data;
  }
}

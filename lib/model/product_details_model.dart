class ProductDetailsModel {
  int? id;
  String? title;
  String? short;
  String? description;
  int? price;
  String? img;
  String? newOld;
  bool? onSale;
  bool? slider;
  bool? trending;
  bool? latest;
  bool? bestDeal;
  String? createAt;
  String? updateAt;
  List? category;
  List? subcategory;
  List? microcategory;
  List? color;
  List? size;
  List? brand;
  List? tag;
  List<Images>? images;

  ProductDetailsModel(
      {this.id,
      this.title,
      this.short,
      this.description,
      this.price,
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
      this.microcategory,
      this.color,
      this.size,
      this.brand,
      this.tag,
      this.images});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    short = json['short'];
    description = json['description'];
    price = json['price'];
    img = json['img'];
    newOld = json['new_old'];
    onSale = json['on_sale'];
    slider = json['slider'];
    trending = json['trending'];
    latest = json['latest'];
    bestDeal = json['best_deal'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
    category = json['category'];
    subcategory = json['subcategory'];
    microcategory = json['microcategory'];
    color = json['color'];
    size = json['size'];
    brand = json['brand'];
    tag = json['tag'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short'] = this.short;
    data['description'] = this.description;
    data['price'] = this.price;
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
    data['microcategory'] = this.microcategory;
    data['color'] = this.color;
    data['size'] = this.size;
    data['brand'] = this.brand;
    data['tag'] = this.tag;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? img;
  int? products;

  Images({this.id, this.img, this.products});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    products = json['products'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['products'] = this.products;
    return data;
  }
}

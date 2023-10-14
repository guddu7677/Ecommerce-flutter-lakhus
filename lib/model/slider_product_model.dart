class SliderProductModel {
  int? id;
  // int? category;
  // int? subcategory;
  // int? microcategory;
  // int? color;
  // int? size;
  // int? brand;
  // int? tag;
  String? title;
  int? price;
  String? newOld;
  bool? onSale;
  bool? slider;
  bool? trending;
  bool? latest;
  String? img;

  SliderProductModel(
      {this.id,
      // this.category,
      // this.subcategory,
      // this.microcategory,
      // this.color,
      // this.size,
      // this.brand,
      // this.tag,
      this.title,
      this.price,
      this.newOld,
      this.onSale,
      this.slider,
      this.trending,
      this.latest,
      this.img});

  SliderProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // category = json['category'];
    // subcategory = json['subcategory'];
    // microcategory = json['microcategory'];
    // color = json['color'];
    // size = json['size'];
    // brand = json['brand'];
    // tag = json['tag'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    // data['category'] = this.category;
    // data['subcategory'] = this.subcategory;
    // data['microcategory'] = this.microcategory;
    // data['color'] = this.color;
    // data['size'] = this.size;
    // data['brand'] = this.brand;
    // data['tag'] = this.tag;
    data['title'] = this.title;
    data['price'] = this.price;
    data['new_old'] = this.newOld;
    data['on_sale'] = this.onSale;
    data['slider'] = this.slider;
    data['trending'] = this.trending;
    data['latest'] = this.latest;
    data['img'] = this.img;
    return data;
  }
}

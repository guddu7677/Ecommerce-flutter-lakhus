class SubCategoryProductModel {
  int id;
//   int category;
//   int subcategory;
//   int microcategory;
//   int color;
//  int size;
//   int brand;
  String title;
  double price;
  String newOld;
  bool onSale;
  bool slider;
  bool trending;
  bool latest;
  String img;

  SubCategoryProductModel({
    required this.id,
    // required this.category,
    // required this.subcategory,
    // required this.microcategory,
    // required this.color,
    // required this.size,
    // required this.brand,
    required this.title,
    required this.price,
    required this.newOld,
    required this.onSale,
    required this.slider,
    required this.trending,
    required this.latest,
    required this.img,
  });

  factory SubCategoryProductModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryProductModel(
      id: json['id'],
      // category: json['category'],
      // subcategory: json['subcategory'],
      // microcategory: json['microcategory'],
      // color: json['color'],
      // size: json['size'],
      // brand: json['brand'],
      title: json['title'],
      price: json['price'].toDouble(),
      newOld: json['new_old'],
      onSale: json['on_sale'],
      slider: json['slider'],
      trending: json['trending'],
      latest: json['latest'],
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'category': category,
      // 'subcategory': subcategory,
      // 'microcategory': microcategory,
      // 'color': color,
      // 'size': size,
      // 'brand': brand,
      'title': title,
      'price': price,
      'new_old': newOld,
      'on_sale': onSale,
      'slider': slider,
      'trending': trending,
      'latest': latest,
      'img': img,
    };
  }
}

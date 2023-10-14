class ProductListModel {
  int id;
  List? category;
  List subcategory;
  // int microcategory;
  // List<dynamic> color;
  // List<dynamic> size;
  // int brand;
  // List<int> tag;
  String title;
  double price;
  String newOld;
  bool onSale;
  dynamic option;
  String img;

 ProductListModel({
    required this.id,
    required this.category,
    required this.subcategory,
    // required this.microcategory,
    // required this.color,
    // required this.size,
    // required this.brand,
    // required this.tag,
    required this.title,
    required this.price,
    required this.newOld,
    required this.onSale,
    required this.option,
    required this.img,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id'],
      category: json['category'],
      subcategory: json['subcategory'],
      // microcategory: json['microcategory'],
      // color: json['color'],
      // size: json['size'],
      // brand: json['brand'],
      // tag: List<int>.from(json['tag']),
      title: json['title'],
      price: json['price'] != null ? json['price'].toDouble() : null,
      newOld: json['new_old'],
      onSale: json['on_sale'],
      option: json['option'],
      img: json['img'],
    );
  }
}

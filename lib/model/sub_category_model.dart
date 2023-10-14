class SubCategoryModel {
  int? id;
  int? category;
  String? name;
  String? img;

  SubCategoryModel({this.id, this.category, this.name, this.img});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    data['img'] = this.img;
    return data;
  }
}

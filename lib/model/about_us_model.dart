class AboutUsModel {
  int? id;
  String? title;
  String? img;
  String? txt;

  AboutUsModel({this.id, this.title, this.img, this.txt});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    img = json['img'];
    txt = json['txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['img'] = this.img;
    data['txt'] = this.txt;
    return data;
  }
}

class SizeDataModel {
  int? id;
  String? name;
  int? number;

  SizeDataModel({this.id, this.name, this.number});

  SizeDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    return data;
  }

  map(String Function(dynamic item) param0) {}
}

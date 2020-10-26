class CategoryResponse {
  String name;
  String description;
  int id;

  CategoryResponse({this.name, this.description, this.id});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}

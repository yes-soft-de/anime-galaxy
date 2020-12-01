
class CategoryResponse {
  String name;
  String description;
  int id;
  String image;

  CategoryResponse({
    this.name,
    this.description,
    this.id,
    this.image,
  });

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}

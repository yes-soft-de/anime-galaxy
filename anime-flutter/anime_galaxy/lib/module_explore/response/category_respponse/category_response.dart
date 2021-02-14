
class CategoryResponse {
  String name;
  String description;
  int id;
  String image;
  String coverImage;
  bool titleShow;

  CategoryResponse({
    this.name,
    this.description,
    this.id,
    this.image,
    this.coverImage,
    this.titleShow,
  });

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
    image = json['image'];
    coverImage = json['coverImage'];
    titleShow = json['titleShow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['id'] = this.id;
    data['image'] = this.image;
    data['coverImage'] = this.coverImage;
    data['titleShow'] = this.titleShow;
    return data;
  }
}

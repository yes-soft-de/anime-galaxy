import 'package:anime_galaxy/module_init_account/response/series_response/series_response.dart';

class CategoryResponse {
  String name;
  String description;
  int id;
  String image;
  bool titleShow;
  String coverImage;
  List<SeriesResponse> series;

  CategoryResponse({
    this.name,
    this.description,
    this.id,
    this.series,
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

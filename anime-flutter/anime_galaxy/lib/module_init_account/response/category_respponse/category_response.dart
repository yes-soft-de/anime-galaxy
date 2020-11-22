import 'package:anime_galaxy/module_init_account/response/series_response/series_response.dart';

class CategoryResponse {
  String name;
  String description;
  int id;
  String image;
  List<SeriesResponse> series;

  CategoryResponse({
    this.name,
    this.description,
    this.id,
    this.series,
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

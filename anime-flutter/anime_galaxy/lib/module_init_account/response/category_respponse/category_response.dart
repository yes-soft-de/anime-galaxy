import 'package:anime_galaxy/module_init_account/response/series_response/series_response.dart';

class CategoryResponse {
  String name;
  String description;
  int id;
  List<SeriesResponse> series;

  CategoryResponse({
    this.name,
    this.description,
    this.id,
    this.series,
  });

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

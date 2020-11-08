
class AnimeResponse {
  int id;
  String animeName;
  String mainImage;
//  List<String> images;
  String categoryName;
  double rating;
  Interactions interactions;
  String description;


  AnimeResponse(
      {this.id,
        this.animeName,
        this.mainImage,
//        this.images,
        this.categoryName,
        this.rating,
        this.interactions,
        this.description,
      });

  AnimeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animeName = json['animeName'];
    mainImage = json['mainImage'];
//    images = json['images'].cast<String>();
    categoryName = json['categoryName'];
    description = json['description'];
    rating = json['rating'];
    interactions = json['interactions'] != null
        ? new Interactions.fromJson(json['interactions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['animeName'] = this.animeName;
    data['mainImage'] = this.mainImage;
//    data['images'] = this.images;
    data['categoryName'] = this.categoryName;
    data['description'] = this.description;
    data['rating'] = this.rating;
    if (this.interactions != null) {
      data['interactions'] = this.interactions.toJson();
    }
    return data;
  }
}

class Interactions {
  String love;
  String like;
  String dislike;

  Interactions({this.love, this.like, this.dislike});

  Interactions.fromJson(Map<String, dynamic> json) {
    love = json['love'];
    like = json['like'];
    dislike = json['dislike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['love'] = this.love;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    return data;
  }
}

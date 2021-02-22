class SeriesYouMayLikeResponse {
  int id;
  String animeName;
  String animeMainImage;
  String rating;
  String categoryName;
  int categoryID;

  SeriesYouMayLikeResponse(
      {this.id,
        this.animeName,
        this.animeMainImage,
        this.rating,
        this.categoryName,
        this.categoryID});

  SeriesYouMayLikeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animeName = json['animeName'];
    animeMainImage = json['animeMainImage'];
    rating = json['rating'];
    categoryName = json['categoryName'];
    categoryID = json['categoryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['animeName'] = this.animeName;
    data['animeMainImage'] = this.animeMainImage;
    data['rating'] = this.rating;
    data['categoryName'] = this.categoryName;
    data['categoryID'] = this.categoryID;
    return data;
  }
}

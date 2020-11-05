class SeriesResponse {
  int id;
  String name;
  String mainImage;
  double rating;
  String comments;
  Interaction interaction;

  SeriesResponse(
      {this.id,
        this.name,
        this.mainImage,
        this.rating,
        this.comments,
        this.interaction});

  SeriesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainImage = json['mainImage'];
    rating   != null ? json['rating'] :0.0;
    comments = json['comments'];
    interaction = json['interaction'] != null
        ? new Interaction.fromJson(json['interaction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mainImage'] = this.mainImage;
    data['rating'] = this.rating;
    data['comments'] = this.comments;
    if (this.interaction != null) {
      data['interaction'] = this.interaction.toJson();
    }
    return data;
  }
}

class Interaction {
  String love;
  String like;
  String dislike;

  Interaction({this.love, this.like, this.dislike});

  Interaction.fromJson(Map<String, dynamic> json) {
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

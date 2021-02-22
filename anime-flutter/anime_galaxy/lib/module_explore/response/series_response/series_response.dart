class SeriesResponse {
  int id;
  String name;
  String mainImage;
  String rating;
  int comments;
  int episodesCount;
  String generalRating;
  String ageGroup;
  Interaction interaction;
  String imageURL;
  String baseURL;
  PublishDate publishDate;

  SeriesResponse(
      {this.id,
        this.name,
        this.mainImage,
        this.rating,
        this.comments,
        this.interaction,
        this.imageURL,
        this.baseURL,
        this.episodesCount,
        this.publishDate,
        this.generalRating,
        this.ageGroup});

  SeriesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainImage = json['mainImage'];
    rating = json['rating'];
    comments = json['comments'];
    interaction = json['interaction'] != null
        ? new Interaction.fromJson(json['interaction'])
        : null;
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
    episodesCount = json['episodesCount'];
    publishDate = json['publishDate'] != null
        ? new PublishDate.fromJson(json['publishDate'])
        : null;
    generalRating = json['generalRating'];
    ageGroup = json['ageGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['mainImage'] = this.mainImage;
    data['rating'] = this.rating;
    data['comments'] = this.comments;
    if (this.interaction != null) {
      data['interaction'] = this.interaction.toJson();
    }
    data['imageURL'] = this.imageURL;
    data['baseURL'] = this.baseURL;
    data['episodesCount'] = this.episodesCount;
    if (this.publishDate != null) {
      data['publishDate'] = this.publishDate.toJson();
    }
    data['generalRating'] = this.generalRating;
    data['ageGroup'] = this.ageGroup;
    return data;
  }
}

class Interaction {
  int love;
  int like;
  int dislike;

  Interaction({this.love, this.like, this.dislike});

  Interaction.fromJson(Map<String, dynamic> json) {
    love = json['love'];
    like = json['like'];
    dislike = json['dislike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['love'] = this.love;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    return data;
  }
}

class PublishDate {
  Timezone timezone;
  int offset;
  int timestamp;

  PublishDate({this.timezone, this.offset, this.timestamp});

  PublishDate.fromJson(Map<String, dynamic> json) {
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
    offset = json['offset'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.timezone != null) {
      data['timezone'] = this.timezone.toJson();
    }
    data['offset'] = this.offset;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Timezone {
  String name;
  List<Transitions> transitions;
  Location location;

  Timezone({this.name, this.transitions, this.location});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['transitions'] != null) {
      transitions = <Transitions>[];
      json['transitions'].forEach((v) {
        transitions.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    if (this.transitions != null) {
      data['transitions'] = this.transitions.map((v) => v.toJson()).toList();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}

class Transitions {
  int ts;
  String time;
  int offset;
  bool isdst;
  String abbr;

  Transitions({this.ts, this.time, this.offset, this.isdst, this.abbr});

  Transitions.fromJson(Map<String, dynamic> json) {
    ts = json['ts'];
    time = json['time'];
    offset = json['offset'];
    isdst = json['isdst'];
    abbr = json['abbr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ts'] = this.ts;
    data['time'] = this.time;
    data['offset'] = this.offset;
    data['isdst'] = this.isdst;
    data['abbr'] = this.abbr;
    return data;
  }
}

class Location {
  String countryCode;
  int latitude;
  int longitude;
  String comments;

  Location({this.countryCode, this.latitude, this.longitude, this.comments});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}

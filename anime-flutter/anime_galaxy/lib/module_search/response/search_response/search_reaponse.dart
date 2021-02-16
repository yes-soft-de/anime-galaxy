class SearchResponse {
  int id;
  String name;
  String mainImage;
 // Null images;
  String rating;
  int comments;
  List<Categories> categories;
  Interactions interactions;
  String description;
  int episodesCount;
  String trailerVideo;
  PublishDate publishDate;
  String imageURL;
  String baseURL;
  String generalRating;
  String ageGroup;
  Null posterImage;
  Null posterImageURL;
  Null createdAt;
  Null updatedAt;
  Null updatedBy;
  Null createdBy;

  SearchResponse(
      {this.id,
        this.name,
        this.mainImage,
      //  this.images,
        this.rating,
        this.comments,
        this.categories,
        this.interactions,
        this.description,
        this.episodesCount,
        this.trailerVideo,
        this.publishDate,
        this.imageURL,
        this.baseURL,
        this.generalRating,
        this.ageGroup,
        this.posterImage,
        this.posterImageURL,
        this.createdAt,
        this.updatedAt,
        this.updatedBy,
        this.createdBy});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainImage = json['mainImage'];
 //   images = json['images'];
    rating = json['rating'];
    comments = json['comments'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    interactions = json['interactions'] != null
        ? new Interactions.fromJson(json['interactions'])
        : null;
    description = json['description'];
    episodesCount = json['episodesCount'];
    trailerVideo = json['trailerVideo'];
    publishDate = json['publishDate'] != null
        ? new PublishDate.fromJson(json['publishDate'])
        : null;
    imageURL = json['imageURL'];
    baseURL = json['baseURL'];
    generalRating = json['generalRating'];
    ageGroup = json['ageGroup'];
    posterImage = json['posterImage'];
    posterImageURL = json['posterImageURL'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mainImage'] = this.mainImage;
   // data['images'] = this.images;
    data['rating'] = this.rating;
    data['comments'] = this.comments;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.interactions != null) {
      data['interactions'] = this.interactions.toJson();
    }
    data['description'] = this.description;
    data['episodesCount'] = this.episodesCount;
    data['trailerVideo'] = this.trailerVideo;
    if (this.publishDate != null) {
      data['publishDate'] = this.publishDate.toJson();
    }
    data['imageURL'] = this.imageURL;
    data['baseURL'] = this.baseURL;
    data['generalRating'] = this.generalRating;
    data['ageGroup'] = this.ageGroup;
    data['posterImage'] = this.posterImage;
    data['posterImageURL'] = this.posterImageURL;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['updatedBy'] = this.updatedBy;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class Categories {
  int id;
  String name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Interactions {
  int love;
  int like;
  int dislike;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
      transitions = new List<Transitions>();
      json['transitions'].forEach((v) {
        transitions.add(new Transitions.fromJson(v));
      });
    }
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['comments'] = this.comments;
    return data;
  }
}




class EpisodeResponse {
  List<Comments> comments;
  String rating;
  String animeName;
  int seasonNumber;
  int episodeNumber;
  String description;
  String image;
  CreationDate duration;
  CreationDate publishDate;
  CreationDate createdAt;
  CommentInteractions interactions;
  String categoryName;
  CreationDate animePublishDate;
  int previousRate;

  EpisodeResponse(
      {this.comments,
        this.rating,
        this.animeName,
        this.seasonNumber,
        this.episodeNumber,
        this.description,
        this.image,
        this.duration,
        this.publishDate,
        this.createdAt,
        this.interactions,
        this.categoryName,
        this.animePublishDate,
        this.previousRate
      });

  EpisodeResponse.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    rating = json['rating'];
    animeName = json['animeName'];
    seasonNumber = json['seasonNumber'];
    episodeNumber = json['episodeNumber'];
    description = json['description'];
    image = json['image'];
    duration = json['duration'] != null
        ? new CreationDate.fromJson(json['duration'])
        : null;
    publishDate = json['publishDate'] != null
        ? new CreationDate.fromJson(json['publishDate'])
        : null;
    createdAt = json['createdAt'] != null
        ? new CreationDate.fromJson(json['createdAt'])
        : null;
    interactions = json['interactions'] != null
        ? new CommentInteractions.fromJson(json['interactions'])
        : null;
    categoryName = json['categoryName'];
    animePublishDate = json['animePublishDate'] != null
        ? new CreationDate.fromJson(json['animePublishDate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['animeName'] = this.animeName;
    data['seasonNumber'] = this.seasonNumber;
    data['episodeNumber'] = this.episodeNumber;
    data['description'] = this.description;
    data['image'] = this.image;
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    if (this.publishDate != null) {
      data['publishDate'] = this.publishDate.toJson();
    }
    if (this.createdAt != null) {
      data['createdAt'] = this.createdAt.toJson();
    }
    if (this.interactions != null) {
      data['interactions'] = this.interactions.toJson();
    }
    data['categoryName'] = this.categoryName;
    if (this.animePublishDate != null) {
      data['animePublishDate'] = this.animePublishDate.toJson();
    }
    return data;
  }
}

class Comments {
  String comment;
  bool spoilerAlert;
  CreationDate creationDate;
  CommentInteractions commentInteractions;
  String userName;
  Null image;

  Comments(
      {this.comment,
        this.spoilerAlert,
        this.creationDate,
        this.commentInteractions,
        this.userName,
        this.image});

  Comments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    spoilerAlert = json['spoilerAlert'];
    creationDate = json['creationDate'] != null
        ? new CreationDate.fromJson(json['creationDate'])
        : null;
    commentInteractions = json['commentInteractions'] != null
        ? new CommentInteractions.fromJson(json['commentInteractions'])
        : null;
    userName = json['userName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['spoilerAlert'] = this.spoilerAlert;
    if (this.creationDate != null) {
      data['creationDate'] = this.creationDate.toJson();
    }
    if (this.commentInteractions != null) {
      data['commentInteractions'] = this.commentInteractions.toJson();
    }
    data['userName'] = this.userName;
    data['image'] = this.image;
    return data;
  }
}

class CreationDate {
  Timezone timezone;
  int offset;
  int timestamp;

  CreationDate({this.timezone, this.offset, this.timestamp});

  CreationDate.fromJson(Map<String, dynamic> json) {
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

class CommentInteractions {
  String love;
  String like;
  String dislike;

  CommentInteractions({this.love, this.like, this.dislike});

  CommentInteractions.fromJson(Map<String, dynamic> json) {
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

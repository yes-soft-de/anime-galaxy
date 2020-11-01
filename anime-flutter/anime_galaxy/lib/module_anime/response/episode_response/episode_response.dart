class EpisodeResponse {
  int id;
  String animeName;
  int seasonNumber;
  int episodeNumber;
  String description;
  String image;
  Duration duration;
  Duration publishDate;
  Duration createdAt;
  EpisodInteraction episodInteraction;
  String comments;
  Null rating;

  EpisodeResponse(
      {this.id,
        this.animeName,
        this.seasonNumber,
        this.episodeNumber,
        this.description,
        this.image,
        this.duration,
        this.publishDate,
        this.createdAt,
        this.episodInteraction,
        this.comments,
        this.rating});

  EpisodeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animeName = json['animeName'];
    seasonNumber = json['seasonNumber'];
    episodeNumber = json['episodeNumber'];
    description = json['description'];
    image = json['image'];
    duration = json['duration'] != null
        ? new Duration.fromJson(json['duration'])
        : null;
    publishDate = json['publishDate'] != null
        ? new Duration.fromJson(json['publishDate'])
        : null;
    createdAt = json['createdAt'] != null
        ? new Duration.fromJson(json['createdAt'])
        : null;
    episodInteraction = json['episodInteraction'] != null
        ? new EpisodInteraction.fromJson(json['episodInteraction'])
        : null;
    comments = json['comments'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    if (this.episodInteraction != null) {
      data['episodInteraction'] = this.episodInteraction.toJson();
    }
    data['comments'] = this.comments;
    data['rating'] = this.rating;
    return data;
  }
}

class Duration {
  Timezone timezone;
  int offset;
  int timestamp;

  Duration({this.timezone, this.offset, this.timestamp});

  Duration.fromJson(Map<String, dynamic> json) {
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

class EpisodInteraction {
  String love;
  String like;
  String dislike;

  EpisodInteraction({this.love, this.like, this.dislike});

  EpisodInteraction.fromJson(Map<String, dynamic> json) {
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

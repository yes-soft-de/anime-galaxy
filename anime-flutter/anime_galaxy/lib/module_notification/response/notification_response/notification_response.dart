class NotificationResponse {
  int id;
  int animeID;
  String mainImage;
  String animeName;
  int categoryID;
  String categoryName;
  int episodeID;
  PublishDate publishDate;

  NotificationResponse(
      {this.id,
        this.animeID,
        this.mainImage,
        this.animeName,
        this.categoryID,
        this.categoryName,
        this.episodeID,
        this.publishDate});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animeID = json['animeID'];
    mainImage = json['mainImage'];
    animeName = json['AnimeName'];
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    episodeID = json['episodeID'];
    publishDate = json['publishDate'] != null
        ? new PublishDate.fromJson(json['publishDate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['animeID'] = this.animeID;
    data['mainImage'] = this.mainImage;
    data['AnimeName'] = this.animeName;
    data['categoryID'] = this.categoryID;
    data['categoryName'] = this.categoryName;
    data['episodeID'] = this.episodeID;
    if (this.publishDate != null) {
      data['publishDate'] = this.publishDate.toJson();
    }
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

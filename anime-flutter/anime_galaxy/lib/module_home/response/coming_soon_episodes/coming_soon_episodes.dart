import 'package:anime_galaxy/consts/urls.dart';

class ComingSoonEpisodesResponse {
  int id;
  String animeName;
  int seasonNumber;
  int episodeNumber;
  String description;
  String image;
  ResponseDuration duration;
  ResponseDuration publishDate;
  ResponseDuration createdAt;
  String categoryName;

  ComingSoonEpisodesResponse(
      {this.animeName,
      this.seasonNumber,
      this.episodeNumber,
      this.description,
      this.image,
      this.duration,
      this.publishDate,
      this.createdAt,
        this.categoryName,
        this.id,
      });

  ComingSoonEpisodesResponse.fromJson(Map<String, dynamic> json) {
    animeName = json['animeName'];
    seasonNumber = json['seasonNumber'];
    episodeNumber = json['episodeNumber'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
    categoryName = json['categoryName'];
    image.replaceFirst('http://localhost:8000', Urls.DOMAIN);
    duration = json['duration'] != null
        ? new ResponseDuration.fromJson(json['duration'])
        : null;
    publishDate = json['publishDate'] != null
        ? new ResponseDuration.fromJson(json['publishDate'])
        : null;
    createdAt = json['createdAt'] != null
        ? new ResponseDuration.fromJson(json['createdAt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['animeName'] = this.animeName;
    data['seasonNumber'] = this.seasonNumber;
    data['episodeNumber'] = this.episodeNumber;
    data['description'] = this.description;
    data['image'] = this.image;
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    if (this.duration != null) {
      data['duration'] = this.duration.toJson();
    }
    if (this.publishDate != null) {
      data['publishDate'] = this.publishDate.toJson();
    }
    if (this.createdAt != null) {
      data['createdAt'] = this.createdAt.toJson();
    }
    return data;
  }
}

class ResponseDuration {
  Timezone timezone;
  int offset;
  int timestamp;

  ResponseDuration({this.timezone, this.offset, this.timestamp});

  ResponseDuration.fromJson(Map<String, dynamic> json) {
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

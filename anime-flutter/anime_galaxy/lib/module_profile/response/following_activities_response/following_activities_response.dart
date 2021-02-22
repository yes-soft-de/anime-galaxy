class FollowingActivitiesResponse {
  String userName;
  String userID;
  String animeName;
  int animeID;
  int commentID;
  String comment;
  Date date;
  int ratingID;
  int favouriteID;
  String userImage;

  FollowingActivitiesResponse(
      {this.userName,
        this.userID,
        this.animeName,
        this.animeID,
        this.commentID,
        this.comment,
        this.date,
        this.ratingID,
        this.favouriteID,
        this.userImage});

  FollowingActivitiesResponse.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userID = json['userID'];
    animeName = json['AnimeName'];
    animeID = json['animeID'];
    commentID = json['commentID'];
    comment = json['comment'];
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    ratingID = json['RatingID'];
    favouriteID = json['favouriteID'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = this.userName;
    data['userID'] = this.userID;
    data['AnimeName'] = this.animeName;
    data['animeID'] = this.animeID;
    data['commentID'] = this.commentID;
    data['comment'] = this.comment;
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['RatingID'] = this.ratingID;
    data['favouriteID'] = this.favouriteID;
    data['userImage'] = this.userImage;
    return data;
  }
}

class Date {
  Timezone timezone;
  int offset;
  int timestamp;

  Date({this.timezone, this.offset, this.timestamp});

  Date.fromJson(Map<String, dynamic> json) {
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

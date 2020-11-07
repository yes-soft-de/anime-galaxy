class CommentResponse {
  String comment;
  bool spoilerAlert;
  CreationDate creationDate;
  CommentInteractions commentInteractions;

  CommentResponse(
      {this.comment,
        this.spoilerAlert,
        this.creationDate,
        this.commentInteractions});

  CommentResponse.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    spoilerAlert = json['spoilerAlert'];
    creationDate = json['creationDate'] != null
        ? new CreationDate.fromJson(json['creationDate'])
        : null;
    commentInteractions = json['commentInteractions'] != null
        ? new CommentInteractions.fromJson(json['commentInteractions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    data['spoilerAlert'] = this.spoilerAlert;
    if (this.creationDate != null) {
      data['creationDate'] = this.creationDate.toJson();
    }
    if (this.commentInteractions != null) {
      data['commentInteractions'] = this.commentInteractions.toJson();
    }
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['love'] = this.love;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    return data;
  }
}

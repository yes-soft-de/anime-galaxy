class PreviousCommentsResponse {
  List<AnimeComments> animeComments;
  List<EpisodeComments> episodeComments;

  PreviousCommentsResponse({this.animeComments, this.episodeComments});

  PreviousCommentsResponse.fromJson(Map<String, dynamic> json) {
    if (json['animeComments'] != null) {
      animeComments = <AnimeComments>[];
      json['animeComments'].forEach((v) {
        animeComments.add(new AnimeComments.fromJson(v));
      });
    }
    if (json['episodeComments'] != null) {
      episodeComments = <EpisodeComments>[];
      json['episodeComments'].forEach((v) {
        episodeComments.add(new EpisodeComments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.animeComments != null) {
      data['animeComments'] =
          this.animeComments.map((v) => v.toJson()).toList();
    }
    if (this.episodeComments != null) {
      data['episodeComments'] =
          this.episodeComments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnimeComments {
  String comment;
  bool spoilerAlert;
  int id;
  CreationDate creationDate;
//  Null commentInteractions;
  String userName;
  String image;
  String animeName;

  AnimeComments(
      {this.comment,
        this.spoilerAlert,
        this.id,
        this.creationDate,
//        this.commentInteractions,
        this.userName,
        this.image,
        this.animeName});

  AnimeComments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    spoilerAlert = json['spoilerAlert'];
    id = json['id'];
    creationDate = json['creationDate'] != null
        ? new CreationDate.fromJson(json['creationDate'])
        : null;
//    commentInteractions = json['commentInteractions'];
    userName = json['userName'];
    image = json['image'];
    animeName = json['animeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['comment'] = this.comment;
    data['spoilerAlert'] = this.spoilerAlert;
    data['id'] = this.id;
    if (this.creationDate != null) {
      data['creationDate'] = this.creationDate.toJson();
    }
//    data['commentInteractions'] = this.commentInteractions;
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['animeName'] = this.animeName;
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

class EpisodeComments {
  int id;
  String comment;
  String animeName;
  bool spoilerAlert;
  CreationDate creationDate;
  String userName;
  String image;
  int episodeNumber;

  EpisodeComments(
      {this.id,
        this.comment,
        this.animeName,
        this.spoilerAlert,
        this.creationDate,
        this.userName,
        this.image,
        this.episodeNumber});

  EpisodeComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    animeName = json['animeName'];
    spoilerAlert = json['spoilerAlert'];
    creationDate = json['creationDate'] != null
        ? new CreationDate.fromJson(json['creationDate'])
        : null;
    userName = json['userName'];
    image = json['image'];
    episodeNumber = json['episodeNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['animeName'] = this.animeName;
    data['spoilerAlert'] = this.spoilerAlert;
    if (this.creationDate != null) {
      data['creationDate'] = this.creationDate.toJson();
    }
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['episodeNumber'] = this.episodeNumber;
    return data;
  }
}

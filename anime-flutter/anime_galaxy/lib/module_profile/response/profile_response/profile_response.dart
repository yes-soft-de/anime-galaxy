import 'package:anime_galaxy/module_anime/response/favourite_response/favourite_response.dart';
import 'package:anime_galaxy/module_profile/response/following_activities_response/following_activities_response.dart';



class ProfileResponse {
  Null id;
  String userID;
  String userName;
  String location;
  String story;
  String image;
  CreatedAt createdAt;
  int followingNumber;
  List<FollowingActivitiesResponse> followingActivitiesResponse;
  List<FavouriteResponse> favourites;

  ProfileResponse(
      {this.id,
        this.userID,
        this.userName,
        this.location,
        this.story,
        this.image,
        this.createdAt,
        this.followingNumber,
        this.followingActivitiesResponse,
        this.favourites,
      });

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    userName = json['userName'];
    location = json['location'];
    story = json['story'];
    image = json['image'];
    createdAt = json['createdAt'] != null
        ? new CreatedAt.fromJson(json['createdAt'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['location'] = this.location;
    data['story'] = this.story;
    data['image'] = this.image;
    if (this.createdAt != null) {
      data['createdAt'] = this.createdAt.toJson();
    }
    return data;
  }
}

class CreatedAt {
  Timezone timezone;
  int offset;
  int timestamp;

  CreatedAt({this.timezone, this.offset, this.timestamp});

  CreatedAt.fromJson(Map<String, dynamic> json) {
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

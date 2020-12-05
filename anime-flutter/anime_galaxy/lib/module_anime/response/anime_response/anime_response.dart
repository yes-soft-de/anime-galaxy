
import 'package:anime_galaxy/module_anime/response/episode_response/episode_response.dart';





class AnimeResponse {
  int id;
  String name;
  String mainImage;
  List<Null> images;
  String categoryName;
  String rating;
  List<Comments> comments;
  int categoryID;
  CommentInteractions interactions;
  String description;
  int episodesCount;
  String trailerVideo;
  List<EpisodeResponse> episodes;
  bool isFollowed;
  int previousRate;
  CreationDate publishDate;
  String generalRating;
  String ageGroup;

  AnimeResponse(
      {this.id,
        this.name,
        this.mainImage,

        this.categoryName,
        this.rating,
        this.comments,
        this.categoryID,
        this.interactions,
        this.description,
        this.episodesCount,
        this.trailerVideo,
        this.previousRate,
        this.episodes,
        this.isFollowed,
        this.publishDate,
        this.generalRating,
        this.ageGroup,
      });

  AnimeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainImage = json['mainImage'];
    generalRating = json['generalRating'];
    ageGroup = json['ageGroup'];

    categoryName = json['categoryName'];
    rating = json['rating'];
    if (json['comments'] != null) {
      comments = new List<Comments>();
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    categoryID = json['categoryID'];
    interactions = json['interactions'] != null
        ? new CommentInteractions.fromJson(json['interactions'])
        : null;
    publishDate = json['publishDate'] != null
        ? new CreationDate.fromJson(json['publishDate'])
        : null;
    description = json['description'];
    episodesCount = json['episodesCount'];
    trailerVideo = json['trailerVideo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mainImage'] = this.mainImage;
    data['generalRating'] = this.generalRating;
    data['ageGroup'] = this.ageGroup;

    data['categoryName'] = this.categoryName;
    data['rating'] = this.rating;
    if (this.comments != null) {
      data['comments'] = this.comments.map((v) => v.toJson()).toList();
    }
    data['categoryID'] = this.categoryID;
    if (this.interactions != null) {
      data['interactions'] = this.interactions.toJson();
    }
    if (this.publishDate != null) {
      data['publishDate'] = this.publishDate.toJson();
    }
    data['description'] = this.description;
    data['episodesCount'] = this.episodesCount;
    data['trailerVideo'] = this.trailerVideo;
    return data;
  }
}

class Comments {
  String comment;
  bool spoilerAlert;
  int id;
  CreationDate creationDate;
  CommentInteractions commentInteractions;
  String userName;
  String image;
  String userID;

  Comments(
      {this.comment,
        this.spoilerAlert,
        this.creationDate,
        this.id,
        this.commentInteractions,
        this.userName,
        this.image,
        this.userID,
      });

  Comments.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    id = json['id'];
    spoilerAlert = json['spoilerAlert'];
    creationDate = json['creationDate'] != null
        ? new CreationDate.fromJson(json['creationDate'])
        : null;
    commentInteractions = json['commentInteractions'] != null
        ? new CommentInteractions.fromJson(json['commentInteractions'])
        : null;
    userName = json['userName'];
    userID = json['userID'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['id'] = this.id;
    data['spoilerAlert'] = this.spoilerAlert;
    if (this.creationDate != null) {
      data['creationDate'] = this.creationDate.toJson();
    }
    if (this.commentInteractions != null) {
      data['commentInteractions'] = this.commentInteractions.toJson();
    }
    data['userName'] = this.userName;
    data['image'] = this.image;
    data['userID'] = this.userID;
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
  int love;
  int like;
  int dislike;
  bool isLoved;

  CommentInteractions({this.love, this.like, this.dislike});

  CommentInteractions.fromJson(Map<String, dynamic> json) {
    love = json['love'];
    like = json['like'];
    dislike = json['dislike'];
    isLoved = json['isLoved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['love'] = this.love;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['isLoved'] = this.isLoved;
    return data;
  }
}

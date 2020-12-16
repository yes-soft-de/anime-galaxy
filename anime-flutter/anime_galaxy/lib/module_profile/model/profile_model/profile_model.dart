class ProfileModel {
  String name;
  String image;
  String about;
  List<Series> watchedSeries;
  String followingNumber;
  int seriesNumber;
  List<Activity> followingActivities;
  bool isFollowed;
  String createDate;
  PreviousComments previousComments;
  String commentsNumber;
  String cover;

  ProfileModel({
    this.name,
    this.image,
    this.about,
    this.watchedSeries,
    this.followingNumber,
    this.seriesNumber,
    this.followingActivities,
    this.isFollowed,
    this.createDate,
    this.previousComments,
    this.commentsNumber,
    this.cover
  });


  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}


class Series{
  int id;
  String image;
  String name;
  String classification;

  Series({
    this.id,
    this.image,
    this.name,
    this.classification,
  });
}

class Activity{
  String userName;
  String action;
  String userImage;
  String animeName;
  String date;

  Activity({
    this.userName,
    this.action,
    this.date,
    this.userImage,
    this.animeName,
  });

}
class PreviousComments{
  List<CommentsOnAnime> commentsOnAnime;
  List<CommentsOnEpisode> commentsOnEpisodes;
}
class CommentsOnAnime{
  String animeName;
  String comment;

  CommentsOnAnime({
    this.animeName,
    this.comment,
  });
}
class CommentsOnEpisode  {
  String animeName;
  String comment;
  int episodeNumber;

  CommentsOnEpisode({
    this.comment,
    this.animeName,
    this.episodeNumber,
  });
}
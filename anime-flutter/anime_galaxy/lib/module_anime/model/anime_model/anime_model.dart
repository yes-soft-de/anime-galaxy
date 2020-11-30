class AnimeModel{
  String name;
  String showYear;
  String rate;
  String likesNumber;
  int commentsNumber;
  String image;
  String about;
  String  classification;
  List<Comment> comments;
  List<Episode> episodes;
  bool isFollowed;
  bool isLoved;
  int categoryID;
  int previousRate;
  String trailerVideo;

  AnimeModel({
    this.commentsNumber,
    this.name,
    this.image,
    this.rate,
    this.likesNumber,
    this.about,
    this.classification,
    this.showYear,
    this.comments,
    this.episodes,
    this.isFollowed,
    this.isLoved,
    this.categoryID,
    this.previousRate,
    this.trailerVideo,
  });
}



class Comment{
  String userImage;
  int id;
  String content;
  String date;
  String userName;
  String likesNumber;

  Comment({
    this.date,
    this.userName,
    this.id,
    this.userImage,
    this.content,
    this.likesNumber,
  });
}

class Episode{
  int id;
  int episodeNumber;
  String image;
  String  classification;

  Episode({
    this.id,
    this.classification,
    this.episodeNumber,
    this.image
  });
}
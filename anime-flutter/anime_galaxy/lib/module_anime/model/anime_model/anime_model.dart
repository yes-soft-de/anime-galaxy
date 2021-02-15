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
//  int categoryID;
  List<AnimeCategories> categories;
  int previousRate;
  String trailerVideo;
  String generalRating;
  String ageGroup;


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
//    this.categoryID,
    this.categories,
    this.previousRate,
    this.trailerVideo,
    this.generalRating,
    this.ageGroup,
  });
}

class AnimeCategories {
  int id;
  String name;

  AnimeCategories({this.id, this.name});
}

class Comment{
  String userImage;
  int id;
  String userId;
  String content;
  String date;
  String userName;
  String likesNumber;
  bool isLoved;
  bool spoilerAlert;
  bool canReact;

  Comment({
    this.date,
    this.userName,
    this.id,
    this.userImage,
    this.content,
    this.likesNumber,
    this.isLoved,
    this.userId,
    this.spoilerAlert,
    this.canReact = false,
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
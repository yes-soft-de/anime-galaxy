class EpisodeModel{
  String name;
  String showYear;
  String rate;
  String likesNumber;
  int commentsNumber;
  String image;
  String about;
//  String  classification;
  List<Comment> comments;
  int previousRate;
  bool isLoved;
  String duration;
  List<EpisodeCategories> categories;

  EpisodeModel({
    this.commentsNumber,
    this.name,
    this.image,
    this.rate,
    this.likesNumber,
    this.about,
//    this.classification,
    this.showYear,
    this.comments,
    this.previousRate,
    this.isLoved,
    this.duration,
    this.categories
  });
}



class Comment{
  String userImage;
  String userId;
  String content;
  int id;
  String likesNumber;
  String date;
  String userName;
  bool isLoved;
  bool spoilerAlert;
  bool canReact;

  Comment({
    this.date,
    this.userName,
    this.userImage,
    this.content,
    this.id,
    this.likesNumber,
    this.isLoved,
    this.userId,
    this.spoilerAlert,
    this.canReact = false,
  });
}
class EpisodeCategories {
  int id;
  String name;

  EpisodeCategories({this.id, this.name});
}
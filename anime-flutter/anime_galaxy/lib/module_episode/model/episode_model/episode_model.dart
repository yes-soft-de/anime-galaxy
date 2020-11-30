class EpisodeModel{
  String name;
  String showYear;
  String rate;
  String likesNumber;
  int commentsNumber;
  String image;
  String about;
  String  classification;
  List<Comment> comments;
  int previousRate;
  bool isLoved;

  EpisodeModel({
    this.commentsNumber,
    this.name,
    this.image,
    this.rate,
    this.likesNumber,
    this.about,
    this.classification,
    this.showYear,
    this.comments,
    this.previousRate,
    this.isLoved,
  });
}



class Comment{
  String userImage;
  String content;
  int id;
  String likesNumber;
  String date;
  String userName;

  Comment({
    this.date,
    this.userName,
    this.userImage,
    this.content,
    this.id,
    this.likesNumber,
  });
}

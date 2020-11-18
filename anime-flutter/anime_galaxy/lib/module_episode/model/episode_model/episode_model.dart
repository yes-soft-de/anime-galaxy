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
  });
}



class Comment{
  String userImage;
  String content;
  String date;
  String userName;

  Comment({
    this.date,
    this.userName,
    this.userImage,
    this.content,
  });
}

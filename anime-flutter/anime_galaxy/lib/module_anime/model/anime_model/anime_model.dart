class AnimeModel{
    String name;
    String showYear;
    double rate;
    String likesNumber;
    int commentsNumber;
    String image;
    String about;
    String  classification;
    List<Comment> comments;
    List<Episode> episodes;

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

class Episode{
  int episodeNumber;
  String image;
   String  classification;

  Episode({
    this.classification,
    this.episodeNumber,
    this.image
});
}
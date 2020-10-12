class AnimeModel{
    String name;
    String showYear;
    double rate;
    int likesNumber;
    int commentsNumber;
    String image;
    String about;
    List<AnimeClassification> classifications;
    List<Comment> comments;
    List<Episode> episodes;

    AnimeModel({
      this.commentsNumber,
      this.name,
      this.image,
      this.rate,
      this.likesNumber,
      this.about,
      this.classifications,
      this.showYear,
      this.comments,
      this.episodes,
});
}

class AnimeClassification{
  String name;

  AnimeClassification({
    this.name,
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
   AnimeClassification  classification;

  Episode({
    this.classification,
    this.episodeNumber,
    this.image
});
}
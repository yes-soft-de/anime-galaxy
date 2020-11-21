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
      this.categoryID,
      this.previousRate,
      this.trailerVideo,
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